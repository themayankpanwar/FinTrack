document.addEventListener("DOMContentLoaded", function () {

    const themeToggle = document.getElementById("themeToggle");

    // Load saved theme
    const savedTheme = localStorage.getItem("fintrack-theme");

    if (savedTheme === "light") {
        document.body.classList.add("light-mode");
    }

    updateThemeButton();

    if (themeToggle) {
        themeToggle.addEventListener("click", function () {

            document.body.classList.toggle("light-mode");

            const isLight = document.body.classList.contains("light-mode");

            localStorage.setItem(
                "fintrack-theme",
                isLight ? "light" : "dark"
            );

            updateThemeButton();
        });
    }

    function updateThemeButton() {

        if (!themeToggle) {
            return;
        }

        const isLight = document.body.classList.contains("light-mode");

        if (isLight) {
            themeToggle.innerHTML = "🌙 Dark";
            themeToggle.setAttribute("title", "Switch to dark mode");
        } else {
            themeToggle.innerHTML = "☀️ Light";
            themeToggle.setAttribute("title", "Switch to light mode");
        }
    }
});