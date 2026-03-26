document.addEventListener('contextmenu', e => e.preventDefault());
document.addEventListener('keydown', e => {
    if (e.key === 'F12' || (e.ctrlKey && e.shiftKey && (e.key === 'I' || e.key === 'J' || e.key === 'C')) || (e.ctrlKey && (e.key === 'u' || e.key === 'U' || e.key === 's' || e.key === 'S' || e.key === 'a' || e.key === 'A'))) {
        e.preventDefault();
        return false;
    }
});

const rawUrls = [
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-5-22-125-1001.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-5-22-130-2003.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-5-22-140-1032.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-5-22-152-1025.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-5-22-153-1026.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-5-22-160-1025.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-5-22-163-1004.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-5-22-167-1006.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-.beta.4-0-1-98.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-100-1-1003.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-120-5-110.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-140-2-1004.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-150-11-1001.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-150-8-1008.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-160-10-1119.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-170-0-1042.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-180-0-1051.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-180-10-1006.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-180-10-1006_2.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-200-0-5201.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-205-0-1006.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-210-0-1093.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-210-10-1005.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-215-0-1019.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-220-0-1109.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-240-0-1075.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-240-15-1005.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-240-20-1016.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-240-30-1002.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-250-0-1070.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-260-0-1032.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-270-0-1053.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-280-0-1022.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-30-50.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-40-10-1013.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-4-50-5.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-0-100-2106.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-0-110-2104.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-0-220-1003.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-0-230-1001.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-1-0-1129.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-10-100-1016.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-10-110-1002.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-10-20-1003.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-10-210.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-10-220-1003.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-10-220-1006.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-10-220-1008.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-10-230-1003.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-11-100-1063.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-11-100-2102.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-11-40-1003.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-11-42-1002.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-11-42-2003.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-11-50-2102.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-11-56-1003.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-12-0-1085.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-12-101-1002.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-12-102-1001.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-12-105-1006.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-12-108-2002.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-12-115-1001.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-12-3-1001.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-13-0-1076.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-13-100-1019.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-13-200-1029.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-13-220-1002.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-14-21-1004.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-1001.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-120-1025.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-212-1027.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-219.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-300-1070.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-500-1009.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-550-1031.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-560.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-630-1018.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-642-1004.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-651-1003.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-655-1002.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-21-660.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-22-0-2202.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-22-101-1008.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-22-75-2109.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-22-86-1001.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-3-120.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-3-70-1004.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-4-0-1063.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-4-100-1026.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-5-10.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-6-0.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-7-0.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-8-0.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-9-10-1006.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-9-100.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-9-410-1001.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-9-600-1001.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-9-610-1005.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/bluestacks-app-player-5-9-620.exe",
    "https://github.com/phwyverysad/BlueStacks/releases/download/BlueStacks/BlueStacks.beta.5.0.0.7228.exe"
];

const customLinks = [
    { url: "https://gofile.io/d/U9I23H", filename: "bluestacks-app-player-5-21-218-1001.exe" },
    { url: "https://gofile.io/d/6U8oZg", filename: "bluestacks-app-player-5-21-580-1017.exe" },
    { url: "https://gofile.io/d/XvePjD", filename: "bluestacks-5-22-91-1029.exe" },
    { url: "https://gofile.io/d/l8gp4F", filename: "bluestacks-5-22-166-1003.exe" }
];

const allData = [ ...customLinks, ...rawUrls.map(url => ({ url: url, filename: url.split('/').pop() })) ];
const bs5Links = [];
const bs4Links = [];

allData.forEach(item => {
    let version = "Unknown";
    const filename = item.filename;
    if (filename.includes("beta.5")) {
        version = "Beta 5.0.0.7228";
        bs5Links.push({ url: item.url, version });
        return;
    }
    if (filename.includes(".beta.4")) {
        version = "Beta 4.0.1.98";
        bs4Links.push({ url: item.url, version });
        return;
    }
    const match = filename.match(/bluestacks(?:-app-player)?-([\d-]+)(?:_2)?\.exe/i);
    if (match) {
        version = match[1].replace(/-/g, '.');
        if (version.startsWith('5')) { bs5Links.push({ url: item.url, version }); } 
        else if (version.startsWith('4')) { bs4Links.push({ url: item.url, version }); }
    }
});

function sortVersionsDesc(a, b) {
    const vA = a.version.replace('Beta ', '').split('.').map(Number);
    const vB = b.version.replace('Beta ', '').split('.').map(Number);
    for(let i = 0; i < Math.max(vA.length, vB.length); i++) {
        const numA = vA[i] || 0;
        const numB = vB[i] || 0;
        if (numA > numB) return -1;
        if (numA < numB) return 1;
    }
    return 0;
}

bs5Links.sort(sortVersionsDesc);
bs4Links.sort(sortVersionsDesc);

function generateButtonsHTML(links) {
    return links.map(link => `
        <a href="${link.url}" target="_blank" class="group relative overflow-hidden flex flex-col justify-center p-5 bg-white/70 dark:bg-gray-800/60 rounded-[1.25rem] border border-gray-100 dark:border-gray-700 shadow-sm hover:shadow-xl hover:border-purple-400 dark:hover:border-purple-500 transition-all duration-300 transform hover:-translate-y-1 backdrop-blur-sm">
            <div class="absolute -right-6 -top-6 w-24 h-24 bg-gradient-to-br from-purple-400 to-indigo-500 rounded-full blur-2xl opacity-0 group-hover:opacity-20 dark:group-hover:opacity-30 transition-opacity duration-300 pointer-events-none"></div>
            <div class="flex items-center justify-between z-10 relative">
                <div class="flex items-center gap-4">
                    <div class="flex-shrink-0 w-10 h-10 rounded-xl bg-lavender-100 dark:bg-gray-700/80 flex items-center justify-center text-purple-600 dark:text-purple-400 group-hover:scale-110 group-hover:bg-purple-600 group-hover:text-white dark:group-hover:bg-purple-500 transition-all duration-300 shadow-sm">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path>
                        </svg>
                    </div>
                    <span class="font-semibold text-gray-700 dark:text-gray-200 text-[15px] tracking-wide">${link.version}</span>
                </div>
            </div>
        </a>
    `).join('');
}

document.getElementById('content-bs5').innerHTML = generateButtonsHTML(bs5Links);
document.getElementById('content-bs4').innerHTML = generateButtonsHTML(bs4Links);

function switchTab(tab) {
    const btn5 = document.getElementById('tab-bs5');
    const btn4 = document.getElementById('tab-bs4');
    const content5 = document.getElementById('content-bs5');
    const content4 = document.getElementById('content-bs4');

    const activeBtnClass = "w-full text-left px-5 py-4 rounded-2xl font-bold transition-all duration-300 flex items-center gap-3 shadow-md bg-gradient-to-r from-lavender-100 to-white dark:from-gray-800 dark:to-navy-800 text-purple-800 dark:text-purple-300 border border-purple-300 dark:border-purple-500/50 relative overflow-hidden group";
    const inactiveBtnClass = "w-full text-left px-5 py-4 rounded-2xl font-bold transition-all duration-300 flex items-center gap-3 text-gray-500 dark:text-gray-400 hover:bg-white/60 dark:hover:bg-gray-800/60 hover:text-purple-700 dark:hover:text-purple-300 border border-transparent hover:border-purple-200 dark:hover:border-gray-700 group relative overflow-hidden";
    
    const activeBadge = (num) => `<div class="absolute inset-0 bg-gradient-to-r from-purple-500/10 to-transparent dark:from-purple-500/20"></div><span class="relative z-10 flex items-center justify-center w-9 h-9 rounded-full bg-purple-600 dark:bg-purple-500 text-white text-sm shadow-sm">${num}</span><span class="relative z-10">App Player ${num}</span>`;
    const inactiveBadge = (num) => `<span class="relative z-10 flex items-center justify-center w-9 h-9 rounded-full bg-gray-200 dark:bg-gray-800 text-gray-500 dark:text-gray-400 text-sm group-hover:bg-purple-200 dark:group-hover:bg-purple-900/50 transition-colors">${num}</span><span class="relative z-10">App Player ${num}</span>`;

    content5.classList.add('hidden');
    content4.classList.add('hidden');

    if (tab === 'bs5') {
        btn5.className = activeBtnClass; btn5.innerHTML = activeBadge(5);
        btn4.className = inactiveBtnClass; btn4.innerHTML = inactiveBadge(4);
        content5.classList.remove('hidden');
    } else {
        btn4.className = activeBtnClass; btn4.innerHTML = activeBadge(4);
        btn5.className = inactiveBtnClass; btn5.innerHTML = inactiveBadge(5);
        content4.classList.remove('hidden');
    }
}

const snake = document.getElementById("snake");
const segmentCount = 25;
const segments = [];

for (let i = 0; i < segmentCount; i++) {
    const segment = document.createElement("div");
    segment.classList.add("snake-segment");
    if (i === 0) {
        segment.classList.add("head");
        const leftEye = document.createElement("div");
        leftEye.classList.add("eye", "left");
        const leftPupil = document.createElement("div");
        leftPupil.classList.add("pupil");
        leftEye.appendChild(leftPupil);
        segment.appendChild(leftEye);

        const rightEye = document.createElement("div");
        rightEye.classList.add("eye", "right");
        const rightPupil = document.createElement("div");
        rightPupil.classList.add("pupil");
        rightEye.appendChild(rightPupil);
        segment.appendChild(rightEye);
    }
    snake.appendChild(segment);
    segments.push({
        element: segment,
        x: window.innerWidth / 2,
        y: window.innerHeight / 2,
    });
}

let mouseX = window.innerWidth / 2;
let mouseY = window.innerHeight / 2;

document.addEventListener("mousemove", (e) => {
    mouseX = e.clientX;
    mouseY = e.clientY;
});

function animateSnake() {
    const head = segments[0];
    head.x += (mouseX - head.x) * 0.2;
    head.y += (mouseY - head.y) * 0.2;
    head.element.style.left = (head.x - 30) + "px";
    head.element.style.top = (head.y - 20) + "px";

    for (let i = 1; i < segments.length; i++) {
        const prev = segments[i - 1];
        const curr = segments[i];

        const dx = prev.x - curr.x;
        const dy = prev.y - curr.y;
        const angle = Math.atan2(dy, dx);
        const segmentLength = 15;

        curr.x = prev.x - Math.cos(angle) * segmentLength;
        curr.y = prev.y - Math.sin(angle) * segmentLength;

        const size = 40 - i * 1.2;
        curr.element.style.width = `${Math.max(size, 10)}px`;
        curr.element.style.height = `${Math.max(size, 10)}px`;
        curr.element.style.left = (curr.x - size / 2) + "px";
        curr.element.style.top = (curr.y - size / 2) + "px";
    }
    requestAnimationFrame(animateSnake);
}

animateSnake();