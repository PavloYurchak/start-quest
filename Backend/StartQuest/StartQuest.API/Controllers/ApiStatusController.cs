using Microsoft.AspNetCore.Mvc;
using StartQuest.Application.Abstractions.Messaging;
using StartQuest.Application.Features.ApiStatus.Requests;

namespace StartQuest.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ApiStatusController(ISender sender)
        : AbstractController(sender)
    {
        [HttpGet("status")]
        [ProducesResponseType(typeof(bool), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetStatus(CancellationToken cancellationToken)
            => await HandleRequest(new ApiStatusRequest(), cancellationToken);
    }
}
