<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransparentImage.aspx.cs" Inherits="HospMgmt.TransparentImage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Transparent Image</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.2.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script>
        function showfile(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {

                    var canvas = document.getElementById("myCanvas");
                    var ctx = canvas.getContext("2d");

                    var image = new Image();
                    image.onload = function () {
                        //canvas.style.height = this.height+"px";
                        //canvas.style.width = this.width+"px";
                        //alert(this.width + " " + this.height);
                        ctx.drawImage(image, 0, 0);
                    };
                    image.src = e.target.result;

                    //$.ajax({
                    //    type: 'POST',
                    //    url: 'CommonServices.asmx/GetUpdatedImage',
                    //    dataType: 'json',
                    //    contentType: 'application/json; charset=utf-8',
                    //    success: function (response) {
                    //        $('#lblData').html(JSON.stringify(response));
                    //    },
                    //    error: function (error) {
                    //        console.log(error);
                    //    }
                    //});
                }

                reader.readAsDataURL(input.files[0]);
            }
        }

        $(document).ready(function () {

            $('#myCanvas').mousemove(function (e) {
                var pos = findPos(this);
                var x = e.pageX - pos.x;
                var y = e.pageY - pos.y;
                var coord = "x=" + x + ", y=" + y;
                var c = this.getContext('2d');
                var p = c.getImageData(x, y, 1, 1).data;
                var hex = "#" + ("000000" + rgbToHex(p[0], p[1], p[2])).slice(-6);
                $('#status').html(coord + "    " + hex);
            });

        });
        function findPos(obj) {
            var curleft = 0, curtop = 0;
            if (obj.offsetParent) {
                do {
                    curleft += obj.offsetLeft;
                    curtop += obj.offsetTop;
                } while (obj = obj.offsetParent);
                return { x: curleft, y: curtop };
            }
            return undefined;
        }
        function rgbToHex(r, g, b) {
            if (r > 255 || g > 255 || b > 255)
                throw "Invalid color component";
            return ((r << 16) | (g << 8) | b).toString(16);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <input type="file" id="imgfile" accept="image/*" onchange="showfile(this);" />
                </div>

                <div class="col-lg-12">
                    <div id="status" style="color: red;"></div>
                    <canvas id="myCanvas"  style="border: 1px solid #c3c3c3;height:900px;width:1200px;">Your browser does not support the canvas element.
                    </canvas>

                </div>
            </div>
        </div>  
    </form>
</body>
</html>
