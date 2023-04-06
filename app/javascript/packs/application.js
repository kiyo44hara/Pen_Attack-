// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import "../stylesheets/public/registrations"
import "../stylesheets/public/sessions"
import "../stylesheets/public/tops"
import "../stylesheets/public/members"
import "../stylesheets/public/posts"
import "../stylesheets/public/yells"
import "../stylesheets/admin/admins"
import '@fortawesome/fontawesome-free/js/all'


Rails.start()
Turbolinks.start()
ActiveStorage.start()

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

import Raty from "raty.js"
window.raty = function(elem,opt) {
  let raty =  new Raty(elem,opt)
  raty.init();
  return raty;
}

// ハンバーガーメニューの関数

$(document).on('turbolinks:load', function() {
    $('.hamburger').click(function() {
        $(this).toggleClass('active');

        if ($(this).hasClass('active')) {
            $('.hamburger-menu').addClass('active');
        } else {
            $('.hamburger-menu').removeClass('active');
        }
    });
});


// スライダー
$(document).on('turbolinks:load', function() {
    const mySwiper = new Swiper('.mv01 .swiper', {
        effect: 'fade',
        fadeEffect: {
            crossFade: true,
        },
        loop: true,
        loopAdditionalSlides: 1,
        speed: 2000,
        autoplay: {
            delay: 9000,
            disableOnInteraction: false,
            waitForTransition: false,
        },
        // ドラッグ操作が終わり次第スライド切り替えが行われる
        followFinger: false,
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });
});

// アップロードしたいファイルを選択した時に、ファイル名が表示される

$(document).on('turbolinks:load', function() {
    $('.file_selecter').on('change', function () {
    var file = $(this).prop('files')[0];
    $('.file_name').text(file.name);
    });
});