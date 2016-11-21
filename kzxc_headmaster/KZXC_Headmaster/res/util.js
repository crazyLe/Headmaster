
String.prototype.isPhone = function(){
    var str = this.replace(/\s/ig,"");
    var reg = /^1([358]\d|4[57]|7[067])\d{8}$/;
    return reg.test(str);
};
function initHtmlFontSize(){
    //var _width = window.screen.availWidth;
    var _width = document.body.clientWidth;
    _width = _width>640?640:_width;
    var _fs = _width/16;
    document.getElementsByTagName("html")[0].style.fontSize = _fs+"px";
}
function getObjectURL(file) {
    var url = null ;
    if (window.createObjectURL!=undefined) { // basic
        url = window.createObjectURL(file) ;
    } else if (window.URL!=undefined) { // mozilla(firefox)
        url = window.URL.createObjectURL(file) ;
    } else if (window.webkitURL!=undefined) { // webkit or chrome
        url = window.webkitURL.createObjectURL(file) ;
    }
    return url ;
}

var TMPLOADING = function(){
    this.$loading = null;
    this.init();
};
TMPLOADING.prototype = {
    init:function(){
        this.$loading = $('<section class="temploading"><div></div><div></div><div></div></section>');
        $('body').append(this.$loading);
    },
    show:function(){
        this.$loading.show();
    },
    hide:function(){
        this.$loading.hide();
    }
};
var tmploading = null;

window.alert = function(msg){
    var $alertDiv = $('#alertDiv');
    if($alertDiv.length == 0){
        $alertDiv = $('<div class="msgbox">\
            <div class="msgcnt">\
            <div class="msgtitle">提示</div>\
            <div class="alert-msg" style="font-size:.6rem;color:#666;text-align:center;padding:1rem .5rem;">'+msg+'</div>\
            <div class="msgbtns" style="background:#fdfdfd;">\
            <span style="color:#333;">确定</span></div>\
            </div></div>');
        $('body').append($alertDiv);
    }else{
        $alertDiv.find('.alert-msg').html(msg);
    }
    $alertDiv.show();
    $alertDiv.find('.msgbtns').on('click',function(){
        $alertDiv.hide();
    });
};

window.confirm = function(msg, callback){
    var $confirmDiv = $('#confirmDiv');
    if($confirmDiv.length == 0){
        $confirmDiv = $('<div class="msgbox">\
            <div class="msgcnt">\
            <div class="msgtitle">提示</div>\
            <div class="alert-msg" style="font-size:.6rem;color:#666;text-align:center;padding:1rem .5rem;">'+msg+'</div>\
            <div class="msgbtns" style="background:#fdfdfd;">\
            <span class="sure" style="color:#333;">确定</span>\
            <span class="cancel" style="color:#ff5d5d;">取消</span>\
            </div>\
            </div></div>');
        $('body').append($confirmDiv);
    }else{
        $confirmDiv.find('.alert-msg').html(msg);
    }
    $confirmDiv.show();
    $confirmDiv.find('.sure').on('click',function(){
        $confirmDiv.hide();
        callback(true);
    });
    $confirmDiv.find('.cancel').on('click',function(){
        $confirmDiv.hide();
        callback(false);
    });
};

function initTouchScroll($objs, height){
    if($objs.length <= 0){return false;}
    var t_y = 0;
    $('body')[0].addEventListener('touchstart', function(evt){
        t_y = evt.touches[0].pageY;
    });
    $('body')[0].addEventListener('touchend', function(){
        t_y = 0;
        $objs.stop().animate({'height':height+'rem'}, 50, 'linear');
    });
    $('body')[0].addEventListener('touchmove', function(evt){
        if($(document).scrollTop() == 0){
            if(evt.touches[0].pageY > t_y){
                evt.preventDefault();
            }
            var m = evt.touches[0].pageY - t_y;
            if(m > 0){
                var s = m/1000+1;
                $objs.stop().animate({'height':height*s+'rem'}, 50, 'linear');
            }
        }
    });
}

(function($){
    //图片浏览
    $.fn.extend({imgShow:function() {
        var $styleDiv = $('#imgShowStyle');
        if($styleDiv.length < 1){
            $styleDiv = $('<style id="imgShowStyle"></style>');
            $styleDiv.html(".imgShow{position:fixed;left:0;top:0;width:100%;height:100%;background:rgba(0,0,0,.8);z-index:999;display:flex;justify-content:center;align-items: center;}\
                .imgShow img{width:100%;}\
                .imgShow-btns{position:absolute;left:0;bottom:0;width:80%;background:rgba(0,0,0,.8);padding:10px 10%;text-align:center;}\
                .imgShow-btns *{vertical-align:middle;display:inline-block;}\
                .imgShow-prev{width:0;height:0;border:13px solid transparent;border-right:20px solid rgba(255,255,255,.5);}\
                .imgShow-next{width:0;height:0;border:13px solid transparent;border-left:20px solid rgba(255,255,255,.5);}\
                .imgShow-close{position:relative;display:inline-block;width:20px;height:20px;margin:0 20%;}\
                .imgShow-close::before{content:'';display:block;position:absolute;left:0;top:0;width:28px;-webkit-transform:rotate(45deg);background:#FFF;height:1px;-webkit-transform-origin:0 0;}\
                .imgShow-close::after{content:'';display:block;position:absolute;left:-8px;top:0;width:28px;-webkit-transform:rotate(-45deg);background:#FFF;height:1px;-webkit-transform-origin:100% 0;}");
            $('head').append($styleDiv);
        }
        var imglist = $(this);
        var imgid = 'imgShow_'+(new Date().getTime()+Math.round(Math.random()*1000));
        var $imgBox = $('<section class="imgShow '+imgid+'" style="display:none;"></section>');
        var $imgCnt = $('<div class="imgShow-imgs swiper-container"></div>');
        var $imgWrp = $('<div class="swiper-wrapper"></div>');
        var $imgBtns = $('<div class="imgShow-btns"></div>');
        var $btnprev = $('<div class="imgShow-prev"></div>');
        var $btnclose = $('<div class="imgShow-close"></div>');
        var $btnnext = $('<div class="imgShow-next"></div>');
        $btnprev.appendTo($imgBtns);
        $btnclose.appendTo($imgBtns);
        $btnnext.appendTo($imgBtns);
        $imgWrp.appendTo($imgCnt);
        $imgCnt.appendTo($imgBox);
        $imgBtns.appendTo($imgBox);
        $imgBox.appendTo($('body'));
        for(var i= 0,l=imglist.length; i<l; i++){
            $imgWrp.append('<div class="swiper-slide">\
                <img src="'+imglist.eq(i).attr('src')+'" /></div>');
            imglist.eq(i).data('index', i);
        }
        var swiper_show = new Swiper($imgCnt, {
            nextButton: $btnnext,
            prevButton: $btnprev,
            slidesPerView: 1,
            paginationClickable: true,
            spaceBetween: 20,
            loop: true
        });
        $imgBox[0].addEventListener('touchmove', function(evt){
            evt.preventDefault();
        });
        $btnclose.on('click', function(){
            $imgBox.hide();
        });
        imglist.each(function(){
            $(this).on('click', function(){
                var index = $(this).data('index');
                $imgBox.show();
                swiper_show.onResize();
                swiper_show.slideTo(index+1, 0);
            });
        });
        return this;
    }});
})(jQuery);

$(function(){
    initHtmlFontSize();

    tmploading = new TMPLOADING();
    $('.stu-top-audio').on('click', function(){
        var audio = $(this).children('audio')[0];
        if($(this).hasClass('on')){
            $(this).removeClass('on');
            audio.pause();
        }else{
            $(this).addClass('on');
            audio.play();
        }
    });
    $('.msgbtns span').on('click', function(){
        $(this).parents('.msgbox').addClass('hide');
    });


});