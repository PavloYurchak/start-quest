using FluentValidation;
using Microsoft.Extensions.Logging;
using StartQuest.Application.Abstractions.Messaging;
using StartQuest.Application.Features.ApiStatus.Requests;

namespace StartQuest.Application.Features.ApiStatus
{
    internal sealed class ApiStatusHandler(
        IValidator<ApiStatusRequest> validator,
        ILogger<ApiStatusHandler> logger)
        : AbstractHandler<ApiStatusRequest, bool>(validator, logger)
    {
        protected async override Task<HandlerResponse<bool>> HandleRequest(ApiStatusRequest request, CancellationToken cancellationToken)
        {
            var result = await Task.FromResult(true);
            return HandlerResponse<bool>.Ok(result);
        }
    }
}
