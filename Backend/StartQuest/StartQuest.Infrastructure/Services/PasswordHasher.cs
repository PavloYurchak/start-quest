using StartQuest.Domain.Services;
using System.Security.Cryptography;

namespace StartQuest.Infrastructure.Services
{
    internal sealed class PasswordHasher : IPasswordHasher
    {
        private const int SaltSize = 16;
        private const int KeySize = 32;
        private const int Iterations = 100_000;
        private const string AlgorithmName = "PBKDF2-SHA256";

        public string HashPassword(string password, out string? salt, out string? algorithm)
        {
            var saltBytes = RandomNumberGenerator.GetBytes(SaltSize);

            var key = Rfc2898DeriveBytes.Pbkdf2(
                password,
                saltBytes,
                Iterations,
                HashAlgorithmName.SHA256,
                KeySize);

            salt = Convert.ToBase64String(saltBytes);
            algorithm = AlgorithmName;

            return Convert.ToBase64String(key);
        }

        public bool VerifyPassword(string password, string hash, string? salt, string? algorithm)
        {
            if (string.IsNullOrWhiteSpace(password) ||
                string.IsNullOrWhiteSpace(hash) ||
                string.IsNullOrWhiteSpace(salt))
            {
                return false;
            }

            if (!string.Equals(algorithm, AlgorithmName, StringComparison.Ordinal))
            {
                return false;
            }

            byte[] saltBytes;
            byte[] hashBytes;

            try
            {
                saltBytes = Convert.FromBase64String(salt);
                hashBytes = Convert.FromBase64String(hash);
            }
            catch (FormatException)
            {
                return false;
            }

            var computedHash = Rfc2898DeriveBytes.Pbkdf2(
                password,
                saltBytes,
                Iterations,
                HashAlgorithmName.SHA256,
                KeySize);

            return CryptographicOperations.FixedTimeEquals(hashBytes, computedHash);
        }
    }
}