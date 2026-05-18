namespace StartQuest.Domain.Services
{
    public interface IDatabaseInitializer
    {
        Task InitializeAndSeed(CancellationToken cancellationToken = default(CancellationToken));
    }
}
