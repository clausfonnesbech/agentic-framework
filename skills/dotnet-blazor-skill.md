---
name: dotnet-blazor-skill
description: >-
  Use this skill for all C# / .NET 10 implementation work in this project.
  Covers Blazor Server patterns, EF Core 10 with SQL Server, ASP.NET Core
  minimal API and middleware, Microsoft.Identity.Web / Entra ID auth, MudBlazor
  component conventions, dependency injection, async/await best practices, and
  nullable reference types. Load for every coding or code-review task in this
  repository — it is the primary language reference for this project.
---

# .NET / Blazor Server Skill

**Applies to:** ADS Quarterly IT Review — .NET 10, Blazor Server, EF Core 10, SQL Server, MudBlazor, Microsoft.Identity.Web

---

## C# Language Conventions

### Naming
| Element | Convention | Example |
|---------|-----------|---------|
| Classes, records, interfaces | PascalCase | `AdminAuthMiddleware`, `IQuarterService` |
| Public properties & methods | PascalCase | `PublishedAt`, `GetQuarterAsync()` |
| Private fields | `_camelCase` | `_dbContext`, `_logger` |
| Parameters & locals | camelCase | `quarterId`, `returnUrl` |
| Constants | PascalCase | `MigrationLockResource` |
| Async methods | `*Async` suffix | `MigrateAsync()`, `SaveChangesAsync()` |

### Nullable Reference Types
- Project has `<Nullable>enable</Nullable>` — treat every warning as a potential null-dereference bug
- Use `?` for genuinely nullable references; use `!` only when you have proved the value cannot be null
- Prefer `??` and null-conditional `?.` over explicit null checks where readable
- Initialize collections in constructors or with `= [];` (collection expressions, C# 12+)

```csharp
// Prefer
public string Name { get; set; } = null!;          // required, set by EF
public string? Description { get; set; }            // optional
public ICollection<KpiValue> Values { get; set; } = [];

// Avoid
public string Name { get; set; }                    // nullable warning
```

### Records vs Classes
- Use `record` for immutable DTOs/value objects passed between layers
- Use `class` for EF Core entities (EF requires settable properties)

---

## Async/Await

### Rules
1. **Always** `await` `Task`-returning methods — never `.Result` or `.Wait()` on server code (deadlock risk on Blazor Server's synchronisation context)
2. Pass `CancellationToken` through the call chain for I/O operations
3. Do NOT use `async void` — use `async Task`; exception: Blazor event callbacks (see below)
4. `ConfigureAwait(false)` is not needed in Blazor Server (there is no `SynchronizationContext` to configure away from); omit it to keep code clean

```csharp
// Correct
public async Task<Quarter> GetQuarterAsync(int id, CancellationToken ct = default)
{
    return await _db.Quarters.FindAsync([id], ct) ?? throw new KeyNotFoundException();
}

// Wrong — blocks the thread, risks deadlock
public Quarter GetQuarter(int id) => _db.Quarters.FindAsync(id).Result;
```

### Blazor Event Callbacks
Blazor event handlers `(EventCallback)` are `async void`-safe — Blazor wraps them. Use `async Task` for your own methods; let Blazor call them:

```csharp
private async Task HandleSaveAsync()
{
    await _reportService.SaveDraftAsync(Report, CancellationToken);
    StateHasChanged();
}
```

---

## Blazor Server Patterns

### Component Lifecycle
| Override | When to use |
|----------|-------------|
| `OnInitializedAsync` | Load data on first render (server side only) |
| `OnParametersSetAsync` | Re-load when `[Parameter]` values change |
| `OnAfterRenderAsync(firstRender)` | JS interop, focus management |
| `StateHasChanged()` | Force re-render after external state change (e.g. from a service event) |

```csharp
protected override async Task OnInitializedAsync()
{
    Report = await _reportService.GetCurrentDraftAsync(AreaId);
}
```

### Cascading Authentication State
- `AddCascadingAuthenticationState()` is registered in `Program.cs` (US-004)
- In components, inject via `[CascadingParameter] private Task<AuthenticationState> AuthStateTask { get; set; } = null!;`
- Prefer `<AuthorizeView Policy="AdminEntraID">` / `<AuthorizeView>` in markup over code-behind checks

```razor
<AuthorizeView Policy="AdminEntraID">
    <Authorized>
        <MudButton OnClick="DeleteQuarter">Delete</MudButton>
    </Authorized>
</AuthorizeView>
```

### IDisposable / IAsyncDisposable
Implement `IDisposable` on components that subscribe to events, hold timers, or open resources:

```csharp
@implements IDisposable

private System.Timers.Timer? _autoSaveTimer;

public void Dispose()
{
    _autoSaveTimer?.Dispose();
}
```

### EventCallback vs Action
- Use `EventCallback<T>` for component parameters that trigger re-renders — Blazor handles `StateHasChanged` automatically
- Use `Action` / `Func` only for synchronous, non-rendering callbacks

### RenderMode
This project uses `InteractiveServerRenderMode` set globally on `<Routes>`. Do not add per-component `@rendermode` directives unless you have a specific reason.

### Parameter Binding
- Mark all received parameters `[Parameter]` and consider `[EditorRequired]` for mandatory ones
- Do not mutate `[Parameter]` values — copy them to private fields if mutation is needed

---

## EF Core 10 with SQL Server

### DbContext Usage
- Always resolve `AppDbContext` from DI (constructor injection or `IServiceScopeFactory` for background work)
- Never hold `AppDbContext` as a singleton — it is scoped

### Querying
```csharp
// Read-only query — no tracking needed
var areas = await _db.ReportingAreas
    .AsNoTracking()
    .Where(a => a.IsActive)
    .OrderBy(a => a.Name)
    .ToListAsync(ct);

// Load with related data — always explicit Include
var report = await _db.ManagerReports
    .Include(r => r.KpiValues)
        .ThenInclude(v => v.KpiTemplate)
    .FirstOrDefaultAsync(r => r.Id == id, ct);
```

### Saving
```csharp
// Prefer explicit tracking over SaveChanges on disconnected entities
_db.KpiValues.Update(kpiValue);
await _db.SaveChangesAsync(ct);
```

### Migrations
- Generate via `dotnet ef migrations add <Name> --project src/AdsQuarterlyItReview`
- Never hand-edit generated migration files; regenerate if the model changes
- `MigrateAsync()` runs at startup with `sp_getapplock` advisory lock (see `Program.cs`)
- For schema changes that affect existing data, add a `migrationBuilder.Sql(...)` data migration step

### Common Pitfalls
| Pitfall | Fix |
|---------|-----|
| N+1 queries | Add `Include()` / `ThenInclude()` or use projection |
| Tracking write-only reads | Add `AsNoTracking()` on read-only queries |
| String enum columns storing integers | Map with `.HasConversion<string>()` in fluent API — all enums in this project use string storage |
| DateTime vs DateTimeOffset | Use `DateTimeOffset` for timestamps (already used in all entities) |

---

## ASP.NET Core / Dependency Injection

### Service Registration
Register services in `Program.cs` before `builder.Build()`:
- `AddScoped<>` for request-scoped services (EF Core, per-request state)
- `AddSingleton<>` for thread-safe, stateless services
- `AddTransient<>` for lightweight, stateless utilities

### IOptions Pattern
Configuration sections are bound via `IOptions<T>` — never read `IConfiguration` directly in business code:

```csharp
// Register
builder.Services.Configure<AzureAdOptions>(builder.Configuration.GetSection("AzureAd"));

// Inject
public class MyService(IOptions<AzureAdOptions> options)
{
    private readonly AzureAdOptions _config = options.Value;
}
```

### Middleware Order (this project's pipeline)
```
UseExceptionHandler / UseHsts
UseStatusCodePagesWithReExecute
UseHttpsRedirection
UseAuthentication          ← must precede UseAuthorization
UseAuthorization
UseAntiforgery             ← must precede Map* calls
UseMiddleware<AdminAuthMiddleware>
MapRazorPages
MapStaticAssets
MapRazorComponents<App>
```
Do not change this order without understanding the implications.

---

## Microsoft.Identity.Web / Entra ID (US-004)

### Schemes in use
- `"EntraID"` — OIDC scheme (handles the /signin-oidc callback)
- `"EntraIDCookie"` — cookie scheme (persists the session)
- `"AdminEntraID"` — authorization policy requiring `EntraIDCookie`

### Admin protection pattern
1. `AdminAuthMiddleware` intercepts HTTP requests to `/admin/*` → redirects browser, 401 for API clients
2. `AuthorizeRouteView` catches Blazor client-side navigation → shows `<NotAuthorized>` template
3. `<AuthorizeView Policy="AdminEntraID">` hides UI elements from non-admins

### Adding a new admin Razor component / page
```csharp
@page "/admin/quarters"
@attribute [Authorize(Policy = "AdminEntraID")]
```
The middleware + policy combination means both the HTTP request and Blazor circuit are protected.

---

## MudBlazor Conventions

### Component Usage
- Prefer MudBlazor components over raw HTML for all UI (consistency with existing scaffold)
- `<MudText>`, `<MudButton>`, `<MudCard>`, `<MudTable>`, `<MudForm>` are the primary building blocks
- Use `<MudSnackbar>` / `ISnackbar` for toast notifications
- Use `<MudDialog>` for confirmation dialogs (avoid browser `confirm()`)

### Forms & Validation
```razor
<MudForm @ref="_form" @bind-IsValid="@_isValid">
    <MudTextField @bind-Value="model.Name" Required="true" Label="Name" />
    <MudButton Disabled="!_isValid" OnClick="SubmitAsync">Save</MudButton>
</MudForm>
```

### Loading States
Always show a loading indicator while awaiting async data:
```razor
@if (_loading)
{
    <MudProgressCircular Indeterminate="true" />
}
else
{
    <!-- content -->
}
```

---

## Testing (xUnit)

When adding tests (no test project exists yet — create `tests/AdsQuarterlyItReview.Tests/`):

- Use **xUnit** (standard for .NET)
- Use **Moq** or **NSubstitute** for mocking interfaces
- Use **bUnit** for Blazor component testing
- Use EF Core's `UseInMemoryDatabase` for repository unit tests; use a real SQL Server (via TestContainers) for integration tests

```csharp
// Example unit test
public class QuarterServiceTests
{
    [Fact]
    public async Task GetQuarterAsync_ReturnsQuarter_WhenExists()
    {
        var options = new DbContextOptionsBuilder<AppDbContext>()
            .UseInMemoryDatabase("TestDb")
            .Options;
        await using var db = new AppDbContext(options);
        // arrange, act, assert
    }
}
```

---

## Security Checklist (C#-specific)

- [ ] No `string.Format` / interpolation in raw SQL — always use EF Core or `SqlParameter`
- [ ] `returnUrl` validated with `Url.IsLocalUrl()` before use in redirects (open redirect prevention)
- [ ] Secrets read from environment / `IConfiguration`, never hardcoded
- [ ] `[ValidateAntiForgeryToken]` on state-mutating Razor Page handlers
- [ ] No `[AllowAnonymous]` on routes under `/admin/*`
- [ ] Sensitive claims (email, name) not written to application logs

---

## Skill Metadata

**Version:** 1.0
**Created:** 2026-03-24
**Applies to:** ADS Quarterly IT Review — all stories
**Primary consumers:** Coding Agent (08), Code Inspector (09), Tech Lead (06)
**Related skills:** `secure-coding-skill.md`, `authentication-authorization-skill.md`, `database-design-skill.md`
