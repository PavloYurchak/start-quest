using FluentValidation;
using StartQuest.Application.Features.ApiStatus.Requests;

namespace StartQuest.Application.Features.ApiStatus.Validators
{
    public sealed class ApiStatusValidator : AbstractValidator<ApiStatusRequest>;
}
