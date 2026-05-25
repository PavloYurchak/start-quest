using FluentValidation;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using StartQuest.Application.Abstractions.Messaging;
using System.Reflection;

namespace StartQuest.Application
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddApplication(this IServiceCollection services, IConfiguration configuration)
        {
            var asm = Assembly.GetExecutingAssembly();
            services.AddValidatorsFromAssembly(asm);

            services.Scan(scan => scan
            .FromAssemblies(asm)
            .AddClasses(c => c.AssignableTo(typeof(IHandler<,>)), publicOnly: false)
                .AsImplementedInterfaces()
                .WithScopedLifetime());

            services.Scan(scan => scan
                .FromAssemblies(asm)
                .AddClasses(c => c.AssignableTo(typeof(Abstractions.Services.IApplicationService)), publicOnly: false)
                .AsImplementedInterfaces()
                .WithScopedLifetime());

            services.AddScoped<ISender, MessageBus>();

            return services;
        }
    }
}
