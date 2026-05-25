using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using StartQuest.Infrastructure;

var builder = Host.CreateApplicationBuilder(args);

builder.Configuration.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);

builder.Services.AddInfrastructure(builder.Configuration);

var host = builder.Build();
await host.RunAsync();