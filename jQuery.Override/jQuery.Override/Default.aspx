<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="jQuery.Override._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>  
    <script src="Scripts/jquery.override.js" type="text/javascript"></script>
    <script>
        var legacyBehavior = false;
        var functionOverridden = false;
        var cancelFunction = false;

        function overrideTheButton() {
            $('#MainContent_btnTypical').override('onclick', 'click', function (oldFunction, jQueryElement, arguments) {
                if (legacyBehavior) {
                    return oldFunction();
                } else {
                    alert('No legacy behavior!');
                    return false;
                }
            });
            return false;
        }
        function restoreTheButton() {
            legacyBehavior = false;
            $('#MainContent_btnTypical').override('restore');
            return false;
        }

        function LegacyFunction(a,b,c) {
            $('#txaOutput').val($('#txaOutput').val() + '\r\nHello, from legacy function. a is ' + a);
        }

        function overrideTheFuncion() {
            functionOverridden = true;

            //We must assign to LegacyFunction in order to override it
            LegacyFunction = $(document).override(LegacyFunction, function (arguments, oldFunction) {
                $('#txaOutput').val($('#txaOutput').val() + '\r\nHello, from overriding function.');
                return oldFunction();
            });
            return false;
        }

        function subscribeToFunction() {
            if (!functionOverridden) { alert('To see this work, you have to override the function first, then subscribe.'); }
            else {
                $(document).override(LegacyFunction, 'subscribe', function (event) {
                    $('#txaOutput').val($('#txaOutput').val() + '\r\nHello, from subscriber function.');
                    if (cancelFunction) {
                        $('#txaOutput').val($('#txaOutput').val() + '\r\Subscriber function cancelling call to LegacyFunction.');
                        event.cancel = true;
                    }
                });
            }
            return false;
        }
        function cancelLegacyFunction() {
            if (!functionOverridden) { alert('To see this work, you have to override the function first, then subscribe.'); }
            else {
                cancelFunction = true;
                LegacyFunction(1,2,3);
            }
            return false;
        }
        function unsubscribeFromLegacyFunction() {
            if (!functionOverridden) { alert('To see this work, you have to override the function first, then subscribe.'); }
            else {
                $(document).override(LegacyFunction, 'unsubscribe');
                LegacyFunction(1, 2, 3);
            }
            return false;
        }
        function restoreFunction() {
            if (!functionOverridden) { alert('To see this work, you have to override the function first, then subscribe.'); }
            else {
                //Again, this requires assignment
                LegacyFunction = $(document).override(LegacyFunction, 'restore');
                functionOverridden = false;
            }
            return false;
        }
    </script>
    <h2>
        Welcome to ASP.NET!
    </h2>

        <p>Last time a Page_Load (postback, etc.) occurred was: <%=DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToLongTimeString() %></p>
        <p>This is a typical ASP.NET button that does a postback: <asp:Button ID="btnTypical" Text="Typical Button" OnClick="btnTypical_OnClick" runat="server" /></p>
        <p>Click this button to use jQuery.override to override the behavior of this button: <button onclick="return overrideTheButton();">Override it!</button></p>
        <p>Click this button to allow legacy behavior again (from the overridding function): <button onclick="legacyBehavior=true;return false;">Allow Legacy Behavior</button> </p>
        <p>Click this button to restore the element to its original state: <button onclick="return restoreTheButton();">Restore the Button</button></p>
        <p>Now let's override a function. To invoke the LegacyFunction, click this button: <button onclick="LegacyFunction(1,2,3); return false;">Run LegacyFunction</button><button onclick="$('#txaOutput').val(''); return false;">Clear Output</button></p>
        <p>Click this button to override the legacy function: <button onclick="return overrideTheFuncion();">Override the function</button></p>
        <p>Click this button to subscribe to the legacy function: <button onclick="return subscribeToFunction();">Subscribe to function</button></p>
        <p>Click this button to cancel to the legacy function: <button onclick="return cancelLegacyFunction();">Cancel Legacy Function</button></p>
        <p>Click this button to unsubscribe from the legacy function: <button onclick="return unsubscribeFromLegacyFunction();">Unsubscribe From Function</button></p>
        <p>Click this button to restore the legacy function: <button onclick="return restoreFunction();">Restore Function</button></p>
        <p>Legacy output: <textarea rows="6" cols="50" id="txaOutput"></textarea></p>

    <p>
        The project for jQuery.Override can be found at <a href="http://jqueryoverride.codeplex.com"
            title="jQuery Override Codeplex">jqueryoverride on codeplex</a>.
    </p>
</asp:Content>
