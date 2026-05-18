namespace StartQuest.Domain.Services
{
    public interface IPasswordHasher
    {
        string HashPassword(string password, out string? salt, out string? algorithm);

        bool VerifyPassword(string password, string hash, string? salt, string? algorithm);
    }
}
