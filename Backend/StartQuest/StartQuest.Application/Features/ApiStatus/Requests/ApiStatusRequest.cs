using StartQuest.Application.Abstractions.Messaging;

namespace StartQuest.Application.Features.ApiStatus.Requests
{
    public sealed record ApiStatusRequest() : IHandlerRequest<bool>;
}
