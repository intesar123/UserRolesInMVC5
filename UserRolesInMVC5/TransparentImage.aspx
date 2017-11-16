<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransparentImage.aspx.cs" Inherits="HospMgmt.TransparentImage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Transparent Image</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.2.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Scripts/colorpicker/jquery.colorpicker.bygiro.min.css" rel="stylesheet" />
    <script src="Scripts/colorpicker/jquery.colorpicker.bygiro.min.js"></script>
    <style>
        #myCanvas {
            cursor: pointer ;
        }
    </style>
    <script>
        $(document).ready(function () {
            OrginalWidthHeight();

            $('.myColorPicker').colorPickerByGiro({
                preview: '.myColorPicker-preview'
            });
        });
        function OrginalWidthHeight() {
            var canvas = document.getElementById("myCanvas");
            canvas.height = 400;
            canvas.width = 750;

        }
        function showfile() {
            var input = document.getElementById("imgfile");
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {

                    var canvas = document.getElementById("myCanvas");

                    var ctx = canvas.getContext("2d");

                    var image = new Image();

                    image.onload = function () {

                        //alert(this.width + " " + this.height);
                        ctx.drawImage(image, 0, 0, canvas.width, canvas.height);
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
                $("#imgcolorpreview").css("background-color", hex);
            });

        });
        function Zoom_in_out(id) {
            var canvas = document.getElementById("myCanvas");
            var axistozoom = $("#zoomaxis").val();
            if (id == 'reset') {
                OrginalWidthHeight();
            }
            else if (id == 'plus') {
                if (parseInt(axistozoom) == 0)
                {
                    canvas.height += 10;
                }
                else if (parseInt(axistozoom) == 1)
                {
                    canvas.width += 10;

                }
                else if (parseInt(axistozoom) == 2)
                {
                    canvas.width += 10;
                    canvas.height += 10;
                }
                
            }
            else if (id == 'minus') {
                if (parseInt(axistozoom) == 0) {
                    canvas.height -= 10;
                }
                else if (parseInt(axistozoom) == 1) {
                    canvas.width -= 10;

                }
                else if (parseInt(axistozoom) == 2) {
                    canvas.width -= 10;
                    canvas.height -= 10;
                }
            }
            showfile();
        }
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
        function redraw() {
            var canvas = document.getElementById("myCanvas");

            var context = canvas.getContext("2d");
            context.clearRect(0, 0, context.canvas.width, context.canvas.height); // Clears the canvas
            context.strokeStyle = "#df4b26";
            context.lineJoin = "round";
            context.lineWidth = 5;

            for (var i = 0; i < clickX.length; i++) {
                context.beginPath();
                if (clickDrag[i] && i) {
                    context.moveTo(clickX[i - 1], clickY[i - 1]);
                } else {
                    context.moveTo(clickX[i] - 1, clickY[i]);
                }
                context.lineTo(clickX[i], clickY[i]);
                context.closePath();
                context.stroke();
            }
        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row" style="background-color: #146787; color: white;">
                <div class="col-lg-12 text-center">
                    <h3>Image Editor</h3>
                </div>
            </div>
            <div class="row" style="padding-top: 5px">
                <div class="col-lg-2 col-md-3">
                    <input type="file" id="imgfile" class="form-control" accept="image/*" onchange="showfile(this);" />
                </div>
                <div class="col-lg-2 col-md-3">
                    <div class="input-group">
                        <span class="input-group-addon">Zoom</span>
                        <select class="form-control" id="zoomaxis">
                            <option value="0">Only Height</option>
                            <option value="1">Only Width</option>
                            <option value="2" selected="selected">Both</option>
                        </select>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3">
                    <div class="btn-group">
                        <a href="#" id="minus" class="btn btn-danger btn-sm" onclick="Zoom_in_out(this.id)" title="Zoon Out"><span class="glyphicon glyphicon-zoom-out"></span></a>
                        <a href="#" id="reset" class="btn btn-warning btn-sm" onclick="Zoom_in_out(this.id)" title="Reload"><span class="glyphicon glyphicon-repeat"></span></a>
                        <a href="#" id="reset" class="btn btn-primary btn-sm" onclick="redraw()" title="Refresh Canvas"><span class="glyphicon glyphicon-refresh"></span></a>
                        <a href="#" id="plus" class="btn btn-success btn-sm" onclick="Zoom_in_out(this.id)" title="Zoon In"><span class="glyphicon glyphicon-zoom-in"></span></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3">
                    <div class="row-fluid">
                        <div class="row-fluid">
                            <div class="span6">
                                <div class="input-group myColorPicker">
                                    <span class="input-group-addon myColorPicker-preview">&nbsp;</span>
                                    <input type="text" class="form-control" />
                                </div>
                            </div>
                            <div class="span6">
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                </div>
                <div class="col-lg-12">
                    <div id="status" style="color: red; width: 150px; float: left"></div>
                    <div><span id="imgcolorpreview">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div>
                </div>
                <div class="col-lg-12">
                    <canvas id="myCanvas" style="border: 1px solid #c3c3c3;">Your browser does not support the canvas element.
                    </canvas>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
