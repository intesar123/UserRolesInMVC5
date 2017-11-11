<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="timeEx.aspx.cs" Inherits="HospMgmt.timeEx" %>
<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="Scripts/include/ui-1.10.0/ui-lightness/jquery-ui-1.10.0.custom.min.css" type="text/css" />
    <link rel="stylesheet" href="Scripts/jquery.ui.timepicker.css?v=0.3.3" type="text/css" />

    <script type="text/javascript" src="Scripts/include/jquery-1.9.0.min.js"></script>
    <script type="text/javascript" src="Scripts/include/ui-1.10.0/jquery.ui.core.min.js"></script>
    <script type="text/javascript" src="Scripts/include/ui-1.10.0/jquery.ui.widget.min.js"></script>
    <script type="text/javascript" src="Scripts/include/ui-1.10.0/jquery.ui.tabs.min.js"></script>
    <script type="text/javascript" src="Scripts/include/ui-1.10.0/jquery.ui.position.min.js"></script>

    <script type="text/javascript" src="Scripts/jquery.ui.timepicker.js?v=0.3.3"></script>

    <script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>
    <style type="text/css">
        /* some styling for the page */
        body { font-size: 10px; /* for the widget natural size */ }
        #content { font-size: 1.2em; /* for the rest of the page to show at a normal size */
                   font-family: "Lucida Sans Unicode", "Lucida Grande", Verdana, Arial, Helvetica, sans-serif;
                   width: 950px; margin: auto;
        }
        .code { margin: 6px; padding: 9px; background-color: #fdf5ce; border: 1px solid #c77405; }
        fieldset { padding: 0.5em 2em }
        hr { margin: 0.5em 0; clear: both }
        a { cursor: pointer; }
        #requirements li { line-height: 1.6em; }
    </style>

    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-24327002-1']);
        _gaq.push(['_trackPageview']);

        (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

        function plusone_clicked() {
            $('#thankyou').fadeIn(300);
        }

        $(document).ready(function() {
            $('#floating_timepicker').timepicker({
                onSelect: function(time, inst) {
                    $('#floating_selected_time').html('You selected ' + time);
                }
            });

            $('#tabs').tabs();

        });


    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <cc1:TimeSelector ID="TimeSelector9" runat="server" SelectedTimeFormat="TwentyFour" Hour="00" Minute="00" DisplaySeconds="false">
</cc1:TimeSelector>
        <cc1:TimeSelector ID="TimeSelector1" runat="server" SelectedTimeFormat="TwentyFour" Hour="23" Minute="59" DisplaySeconds="false">
</cc1:TimeSelector>
        
    </div>
        <input type="text" style="width: 70px;" id="timepicker_noPeriodLabels" value="00:00" />

        <script type="text/javascript">
            $(document).ready(function() {
                $('#timepicker_noPeriodLabels').timepicker({
                    showPeriodLabels: false
                });
              });

        </script>
    </form>
</body>
</html>
