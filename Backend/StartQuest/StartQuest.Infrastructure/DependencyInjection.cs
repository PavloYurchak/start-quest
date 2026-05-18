using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using StartQuest.Domain.Repositories;
using StartQuest.Domain.Services;
using StartQuest.Infrastructure.Abstraction;
using StartQuest.Infrastructure.Context;
using StartQuest.Infrastructure.Repositories;
using StartQuest.Infrastructure.Services;

namespace StartQuest.Infrastructure
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
        {
            var dbProvider = configuration["Database:Provider"] ?? "SqlServer";
            var connectionString = configuration.GetConnectionString("DefaultConnection");

            services.AddDbContext<StartQuestContext>(options =>
            {
                switch (dbProvider.ToLower())
                {
                    case "SqlServer":
                    default:
                        options.UseSqlServer(connectionString);
                        break;
                }
            });

            services.AddScoped<IDatabaseInitializer, DatabaseInitializer<StartQuestContext>>();

            services.Scan(scan => scan
                .FromAssemblies(typeof(UserRepository).Assembly)
                .AddClasses(c => c.AssignableTo<IDomainRepository>(), publicOnly: false)
                .AsImplementedInterfaces()
                .WithScopedLifetime());

            services.AddScoped<IJwtTokenService, JwtTokenService>();
            services.AddScoped<IPasswordHasher, PasswordHasher>();
            services.AddScoped<IDbTransactionService, DbTransactionService>();

            return services;
        }

    }
}
