using Microsoft.EntityFrameworkCore.Storage;
using StartQuest.Domain.Services;
using StartQuest.Infrastructure.Context;

namespace StartQuest.Infrastructure.Services
{
    internal class DbTransactionService(StartQuestContext context) : IDbTransactionService
    {
        private IDbContextTransaction? dbTransactionService;

        public async Task BeginTransactionAsync(CancellationToken ct)
        {
            dbTransactionService = await context.Database.BeginTransactionAsync(ct);
        }

        public async Task CommitAsync(CancellationToken ct)
        {
            if (dbTransactionService != null)
            {
                await dbTransactionService.CommitAsync(ct);
            }
        }

        public async Task RollbackAsync(CancellationToken ct)
        {
            if (dbTransactionService != null)
            {
                await dbTransactionService.RollbackAsync(ct);
            }
        }
    }
}
