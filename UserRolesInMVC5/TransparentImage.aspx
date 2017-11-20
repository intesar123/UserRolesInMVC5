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
            cursor: pointer;

        }
    </style>
    <script>
        $(document).ready(function () {
            OrginalWidthHeight();
            initialize();
            $('.myColorPicker').colorPickerByGiro({
                preview: '.myColorPicker-preview'
            });
            
            $(".btn-close").on('click', function () {
                var sigCanvas = document.getElementById("myCanvas");
                var context = sigCanvas.getContext("2d");
                context.strokeStyle = $("#txtpaintcolor").val();
            });
        });
        ////////////////Painting
        // works out the X, Y position of the click inside the canvas from the X, Y position on the page
        function getPosition(mouseEvent, sigCanvas) {
            var x, y;
            if (mouseEvent.pageX != undefined && mouseEvent.pageY != undefined) {
                x = mouseEvent.pageX;
                y = mouseEvent.pageY;
            } else {
                x = mouseEvent.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
                y = mouseEvent.clientY + document.body.scrollTop + document.documentElement.scrollTop;
            }

            return { X: x - sigCanvas.offsetLeft, Y: y - sigCanvas.offsetTop };
        }

      

        function initialize() {
            // get references to the canvas element as well as the 2D drawing context
            var sigCanvas = document.getElementById("myCanvas");
            var context = sigCanvas.getContext("2d");
            context.strokeStyle = $("#txtpaintcolor").val();

            // This will be defined on a TOUCH device such as iPad or Android, etc.
            var is_touch_device = 'ontouchstart' in document.documentElement;

            if (is_touch_device) {
                // create a drawer which tracks touch movements
                var drawer = {
                    isDrawing: false,
                    touchstart: function (coors) {
                        context.beginPath();
                        context.moveTo(coors.x, coors.y);
                        this.isDrawing = true;
                    },
                    touchmove: function (coors) {
                        if (this.isDrawing) {
                            context.lineTo(coors.x, coors.y);
                            context.stroke();
                        }
                    },
                    touchend: function (coors) {
                        if (this.isDrawing) {
                            this.touchmove(coors);
                            this.isDrawing = false;
                        }
                    }
                };

                // create a function to pass touch events and coordinates to drawer
                //function draw(event) {

                //   // get the touch coordinates.  Using the first touch in case of multi-touch
                //   var coors = {
                //      x: event.targetTouches[0].pageX,
                //      y: event.targetTouches[0].pageY
                //   };

                //   // Now we need to get the offset of the canvas location
                //   var obj = sigCanvas;

                //   if (obj.offsetParent) {
                //      // Every time we find a new object, we add its offsetLeft and offsetTop to curleft and curtop.
                //      do {
                //         coors.x -= obj.offsetLeft;
                //         coors.y -= obj.offsetTop;
                //      }
                //	  // The while loop can be "while (obj = obj.offsetParent)" only, which does return null
                //	  // when null is passed back, but that creates a warning in some editors (i.e. VS2010).
                //      while ((obj = obj.offsetParent) != null);
                //   }

                //   // pass the coordinates to the appropriate handler
                //   drawer[event.type](coors);
                //}

                function draws(event) {
                    // console.log(event);
                    //event.preventDefault();

                    if (event.targetTouches[0] != undefined) {
                        var pos = findPos(this);
                        var a = e.pageX - pos.x;
                        var b = e.pageY - pos.y;

                        var coors = {
                            x:a,
                            y:b
                        };

                        var obj = sigCanvas;
                        if (obj.offsetParent) {
                            do {
                                coors.x -= obj.offsetLeft;
                                coors.y -= obj.offsetTop;
                            }
                            while ((obj = obj.offsetParent) != null);
                        }
                        console.log("Event: " + event.type);
                        drawer[event.type](coors);
                    }
                    if (event.type == 'touchend') {
                        //console.log(event);
                        var coors = {
                            x: event.changedTouches[0].pageX,
                            y: event.changedTouches[0].pageY
                        };
                        drawer[event.type](coors);

                    }
                    //console.log(event);
                }


                // attach the touchstart, touchmove, touchend event listeners.
                sigCanvas.addEventListener('touchstart', draw, false);
                sigCanvas.addEventListener('touchmove', draw, false);
                sigCanvas.addEventListener('touchend', draw, false);

                // prevent elastic scrolling
                sigCanvas.addEventListener('touchmove', function (event) {
                    event.preventDefault();
                }, false);
            }
            else {

                // start drawing when the mousedown event fires, and attach handlers to
                // draw a line to wherever the mouse moves to
                $("#myCanvas").mousedown(function (mouseEvent) {
                   //---- var position = getPosition(mouseEvent, sigCanvas);

                    var pos = findPos(this);
                    var x = mouseEvent.pageX - pos.x;
                    var y = mouseEvent.pageY - pos.y;
                    $('#status').html("x="+x + " y=" + y);
                    var c = this.getContext('2d');
                    var p = c.getImageData(x, y, 1, 1).data;
                    var hex = "#" + ("000000" + rgbToHex(p[0], p[1], p[2])).slice(-6);
                    $("#imgcolorpreview").css("background-color", hex);
                    context.moveTo(x, y);
                    context.beginPath();

                    // attach event handlers
                    $(this).mousemove(function (mouseEvent) {
                        drawLine(mouseEvent, sigCanvas, context);
                    }).mouseup(function (mouseEvent) {
                        finishDrawing(mouseEvent, sigCanvas, context);
                    }).mouseout(function (mouseEvent) {
                        finishDrawing(mouseEvent, sigCanvas, context);
                    });
                });

            }
        }

        // draws a line to the x and y coordinates of the mouse event inside
        // the specified element using the specified context
        function drawLine(mouseEvent, sigCanvas, context) {
            var pos = findPos(sigCanvas);
            var x = mouseEvent.pageX - pos.x;
            var y = mouseEvent.pageY - pos.y;
          //----  var position = getPosition(mouseEvent, sigCanvas);
            //alert(x+" "+y);
            context.lineTo(x, y);
            context.stroke();
        }

        // draws a line from the last coordiantes in the path to the finishing
        // coordinates and unbind any event handlers which need to be preceded
        // by the mouse down event
        function finishDrawing(mouseEvent, sigCanvas, context) {
            // draw the line to the finishing coordinates
            drawLine(mouseEvent, sigCanvas, context);

            context.closePath();

            // unbind any events which could draw
            $(sigCanvas).unbind("mousemove")
                        .unbind("mouseup")
                        .unbind("mouseout");
        }

        ///////////////End Painting

        function OrginalWidthHeight() {
            var canvas = document.getElementById("myCanvas");
            canvas.height = 750;
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
            var ctx = canvas.getContext("2d");
            var oldCanvas = canvas.toDataURL("image/png");
            var img = new Image();
            img.src = oldCanvas;
          
            var axistozoom = $("#zoomaxis").val();
            if (id == 'reset') {
                img.onload = function () {
                    canvas.height = 750;
                    canvas.width = 750;
                    
                    ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                }
            }
            else if (id == 'plus') {
                if (parseInt(axistozoom) == 0)
                {
                    // canvas.height += 10;
                    img.onload = function () {
                        canvas.height += 10;
                        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                    }
                }
                else if (parseInt(axistozoom) == 1)
                {
                    //canvas.width += 10;
                    img.onload = function () {
                        canvas.width += 10;
                        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                    }

                }
                else if (parseInt(axistozoom) == 2)
                {
                    img.onload = function () {
                        canvas.height += 10;
                        canvas.width += 10;
                        ctx.drawImage(img, 0, 0,canvas.width, canvas.height);
                    }
                    //canvas.width += 10;
                    //canvas.height += 10;
                }
                
            }
            else if (id == 'minus') {
                if (parseInt(axistozoom) == 0) {
                    img.onload = function () {
                        canvas.height -= 10;
                        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                    }
                }
                else if (parseInt(axistozoom) == 1) {
                    img.onload = function () {
                     
                        canvas.width -= 10;
                        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                    }

                }
                else if (parseInt(axistozoom) == 2) {
                    img.onload = function () {
                        canvas.height -= 10;
                        canvas.width -= 10;
                        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                    }
                }
            }
            //showfile();
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
            context.strokeStyle = $("#txtpaintcolor").val();
            context.lineJoin = "round";
            context.lineWidth = 5;

            //for (var i = 0; i < clickX.length; i++) {
            //    context.beginPath();
            //    if (clickDrag[i] && i) {
            //        context.moveTo(clickX[i - 1], clickY[i - 1]);
            //    } else {
            //        context.moveTo(clickX[i] - 1, clickY[i]);
            //    }
            //    context.lineTo(clickX[i], clickY[i]);
            //    context.closePath();
            //    context.stroke();
            //}
            showfile();

        }
       
        function rotateCanvas()
        {
            var i = 0;
            var canvas = document.getElementById('myCanvas');
            //canvas.height = canvas.width;
            var context = canvas.getContext('2d');
           // var heightc = canvas.height;
           // canvas.height = canvas.width;
           // canvas.width = heightc
            var img = new Image();
            img.src = canvas.toDataURL();
            //context.save();
            //context.translate(50, 50);
            //context.rotate(2 / 180 / Math.PI);
            //context.drawImage(img, -16, -16);
            //context.restore();
            //i += 10;

            var degrees = 90;
           // context.clearRect(0, 0, canvas.width, canvas.height);
            context.save();
      
            context.translate(canvas.width / 2, canvas.height / 2);
            context.rotate(degrees * Math.PI / 180);
            context.drawImage(img, -img.width/2 , -img.height/2);
            context.restore();

           
           // showfile();
        }
        
        //function point(x, y, canvas) {
        //    canvas.beginPath();
        //    canvas.arc(x, y, 1, 0, 2 * Math.PI, true);
        //    canvas.fill();
        //}

        /////////////////////Zoom Image in canvas
      
        //var gkhead = new Image;

        //window.onload = function () {
        //    var canvas = document.getElementById("myCanvas");
        //    var ctx = canvas.getContext('2d');
        //    trackTransforms(ctx);

        //    function redraw() {

        //        // Clear the entire canvas
        //        var p1 = ctx.transformedPoint(0, 0);
        //        var p2 = ctx.transformedPoint(canvas.width, canvas.height);
        //        ctx.clearRect(p1.x, p1.y, p2.x - p1.x, p2.y - p1.y);

        //        ctx.save();
        //        ctx.setTransform(1, 0, 0, 1, 0, 0);
        //        ctx.clearRect(0, 0, canvas.width, canvas.height);
        //        ctx.restore();

        //        ctx.drawImage(gkhead, 0, 0);

        //    }
        //    redraw();

        //    var lastX = canvas.width / 2, lastY = canvas.height / 2;

        //    var dragStart, dragged;

        //    canvas.addEventListener('mousedown', function (evt) {
        //        document.body.style.mozUserSelect = document.body.style.webkitUserSelect = document.body.style.userSelect = 'none';
        //        lastX = evt.offsetX || (evt.pageX - canvas.offsetLeft);
        //        lastY = evt.offsetY || (evt.pageY - canvas.offsetTop);
        //        dragStart = ctx.transformedPoint(lastX, lastY);
        //        dragged = false;
        //    }, false);

        //    canvas.addEventListener('mousemove', function (evt) {
        //        lastX = evt.offsetX || (evt.pageX - canvas.offsetLeft);
        //        lastY = evt.offsetY || (evt.pageY - canvas.offsetTop);
        //        dragged = true;
        //        if (dragStart) {
        //            var pt = ctx.transformedPoint(lastX, lastY);
        //            ctx.translate(pt.x - dragStart.x, pt.y - dragStart.y);
        //            redraw();
        //        }
        //    }, false);

        //    canvas.addEventListener('mouseup', function (evt) {
        //        dragStart = null;
        //        if (!dragged) zoom(evt.shiftKey ? -1 : 1);
        //    }, false);

        //    var scaleFactor = 1.1;

        //    var zoom = function (clicks) {
        //        var pt = ctx.transformedPoint(lastX, lastY);
        //        ctx.translate(pt.x, pt.y);
        //        var factor = Math.pow(scaleFactor, clicks);
        //        ctx.scale(factor, factor);
        //        ctx.translate(-pt.x, -pt.y);
        //        redraw();
        //    }

        //    var handleScroll = function (evt) {
        //        var delta = evt.wheelDelta ? evt.wheelDelta / 40 : evt.detail ? -evt.detail : 0;
        //        if (delta) zoom(delta);
        //        return evt.preventDefault() && false;
        //    };

        //    canvas.addEventListener('DOMMouseScroll', handleScroll, false);
        //    canvas.addEventListener('mousewheel', handleScroll, false);
        //};

        //gkhead.src = 'http://phrogz.net/tmp/gkhead.jpg';

        //// Adds ctx.getTransform() - returns an SVGMatrix
        //// Adds ctx.transformedPoint(x,y) - returns an SVGPoint
        //function trackTransforms(ctx) {
        //    var svg = document.createElementNS("http://www.w3.org/2000/svg", 'svg');
        //    var xform = svg.createSVGMatrix();
        //    ctx.getTransform = function () { return xform; };

        //    var savedTransforms = [];
        //    var save = ctx.save;
        //    ctx.save = function () {
        //        savedTransforms.push(xform.translate(0, 0));
        //        return save.call(ctx);
        //    };

        //    var restore = ctx.restore;
        //    ctx.restore = function () {
        //        xform = savedTransforms.pop();
        //        return restore.call(ctx);
        //    };

        //    var scale = ctx.scale;
        //    ctx.scale = function (sx, sy) {
        //        xform = xform.scaleNonUniform(sx, sy);
        //        return scale.call(ctx, sx, sy);
        //    };

        //    var rotate = ctx.rotate;
        //    ctx.rotate = function (radians) {
        //        xform = xform.rotate(radians * 180 / Math.PI);
        //        return rotate.call(ctx, radians);
        //    };

        //    var translate = ctx.translate;
        //    ctx.translate = function (dx, dy) {
        //        xform = xform.translate(dx, dy);
        //        return translate.call(ctx, dx, dy);
        //    };

        //    var transform = ctx.transform;
        //    ctx.transform = function (a, b, c, d, e, f) {
        //        var m2 = svg.createSVGMatrix();
        //        m2.a = a; m2.b = b; m2.c = c; m2.d = d; m2.e = e; m2.f = f;
        //        xform = xform.multiply(m2);
        //        return transform.call(ctx, a, b, c, d, e, f);
        //    };

        //    var setTransform = ctx.setTransform;
        //    ctx.setTransform = function (a, b, c, d, e, f) {
        //        xform.a = a;
        //        xform.b = b;
        //        xform.c = c;
        //        xform.d = d;
        //        xform.e = e;
        //        xform.f = f;
        //        return setTransform.call(ctx, a, b, c, d, e, f);
        //    };

        //    var pt = svg.createSVGPoint();
        //    ctx.transformedPoint = function (x, y) {
        //        pt.x = x; pt.y = y;
        //        return pt.matrixTransform(xform.inverse());
        //    }
        //}


        /////////////////////End Zoom Image in canvas
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
                        <a href="#" id="resetr" class="btn btn-primary btn-sm" onclick="redraw()" title="Refresh Canvas"><span class="glyphicon glyphicon-refresh"></span></a>
                        <a href="#" id="plus" class="btn btn-success btn-sm" onclick="Zoom_in_out(this.id)" title="Zoon In"><span class="glyphicon glyphicon-zoom-in"></span></a>
                        <a href="#" id="rotate" class="btn btn-info btn-sm" onclick="rotateCanvas()" title="Rotate 90 Clock Wise"><span class="glyphicon glyphicon-retweet"></span></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3">
                    <div class="row-fluid">
                        <div class="row-fluid">
                            <div class="span6">
                                <div class="input-group myColorPicker">
                                    <span class="input-group-addon myColorPicker-preview">&nbsp;</span>
                                    <input type="text" id="txtpaintcolor"  class="form-control" />
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
                <div class="col-lg-12" id="sketch">
                    <canvas id="myCanvas" style="border: 1px solid #c3c3c3;">Your browser does not support the canvas element.
                    </canvas>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
