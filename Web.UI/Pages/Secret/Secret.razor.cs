using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using System;

namespace Web.UI.Pages
{
    public partial class Secret
    {
        [Inject]
        protected IJSRuntime _ijsRuntime { get; set; }

        private void OnClick()
        {
            var isWebAssembly = _ijsRuntime is IJSInProcessRuntime;

            if (isWebAssembly)
            {
                Console.WriteLine("The app is running on WebAssembly");
            }
            else
            {
                Console.WriteLine("The app is running on sever-side");
            }

        }
    }
}
