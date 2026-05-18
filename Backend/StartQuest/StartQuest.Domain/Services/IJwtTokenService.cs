using StartQuest.Domain.Models;

namespace StartQuest.Domain.Services
{
    public interface IJwtTokenService
    {
        (string Token, DateTime ExpiresAt) GenerateAccessToken(User user);

        string GenerateRefreshToken();
    }
}
