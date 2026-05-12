using Microsoft.EntityFrameworkCore;
using StartQuest.Domain.Services;

namespace StartQuest.Infrastructure.Abstraction
{
    internal class DatabaseInitializer<TDbContext>(TDbContext context) : IDatabaseInitializer
        where TDbContext : DbContext
    {
        public async Task InitializeAndSeed(CancellationToken cancellationToken = default)
        {
            if (context.Database.GetPendingMigrations().Any())
            {
                await context.Database.MigrateAsync(cancellationToken);
            }
            else
            {
                await context.Database.EnsureCreatedAsync(cancellationToken);
            }
        }
    }
}
