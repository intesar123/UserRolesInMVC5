<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Progressbar.aspx.cs" Inherits="HospMgmt.Progressbar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Scripts/progressbar/jquery-ui.css" rel="stylesheet" />
    <link href="Scripts/progressbar/style.css" rel="stylesheet" />
    <style>
        #custom-handle {
            width: 3em;
            height: 1.6em;
            top: 50%;
            margin-top: -.8em;
            text-align: center;
            line-height: 1.6em;
        }
    </style>

    <script src="Scripts/progressbar/jquery-1.12.4.js"></script>
    <script src="Scripts/progressbar/jquery-ui.js"></script>
    <script>
        $(function () {
            var handle = $("#custom-handle");
            $("#slider").slider({
                create: function () {
                    handle.text($(this).slider("value"));
                },
                slide: function (event, ui) {
                    handle.text(ui.value);
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
            <div style="max-width:400px;margin-left:10%;">
                <div id="slider">
                    <div id="custom-handle" class="ui-slider-handle"></div>
                </div>
            </div>
    </form>
</body>
</html>
