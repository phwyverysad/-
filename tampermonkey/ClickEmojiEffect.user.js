// ==UserScript==
// @name         Emoji Click Effect (Everywhere)
// @namespace    http://tampermonkey.net/
// @version      1.1
// @description  แสดงเอฟเฟกต์อิโมจิเวลาคลิกเมาส์บนทุกเว็บไซต์
// @author       Assistant
// @match        *://*/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    const emojis = ["⭐", "✨", "🔥", "💖", "🌈", "🎉", "🌸", "🍕", "🎈", "🍀", "⚡"];

    const style = document.createElement('style');
    style.innerHTML = `
        .tm-click-emoji {
            position: fixed;
            pointer-events: none;
            user-select: none;
            z-index: 999999;
            font-size: 24px;
            animation: moveUpAndFade 1s ease-out forwards;
        }
        @keyframes moveUpAndFade {
            0% {
                transform: translate(-50%, -50%) scale(0.5);
                opacity: 1;
            }
            100% {
                transform: translate(-50%, -150%) scale(1.5);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(style);

    document.addEventListener('mousedown', function(e) {
        createEmoji(e.clientX, e.clientY);
    });

    function createEmoji(x, y) {
        const span = document.createElement('span');
        span.className = 'tm-click-emoji';
        const randomEmoji = emojis[Math.floor(Math.random() * emojis.length)];
        span.innerText = randomEmoji;
        span.style.left = x + 'px';
        span.style.top = y + 'px';
        document.body.appendChild(span);
        setTimeout(() => {
            span.remove();
        }, 1000);
    }
})();