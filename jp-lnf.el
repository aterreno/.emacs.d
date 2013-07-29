(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq frame-title-format "%b")
(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)
(setq inhibit-splash-screen t)

;; Coloring
(require 'color-theme)

;; Zenburn
;;(require 'zenburn-theme)
;;(load-theme 'zenburn t)

;; Solarized if you wish..
;;(require 'color-theme-sanityinc-solarized)
(color-theme-sanityinc-solarized-light)
;;(color-theme-sanityinc-solarized-dark)

;; a more greenish theme with good contrast
;;(color-theme-sanityinc-tomorrow-slate)

;; Currently I'm using Tomorrow (starker contrast)
;;(require 'color-theme-sanityinc-tomorrow)
;;(color-theme-sanityinc-tomorrow-night)
;;(color-theme-sanityinc-tomorrow-bright)

;; Font size
;;(set-face-attribute 'default nil :height 200 :font "Anonymous Pro")
;; nice big font for the weak sighted, try it with color-theme-sanityinc-tomorrow-slate
(set-face-attribute 'default nil :height 150)

;; Scrolling
(setq scroll-step 1)

;; show time
(setq display-time-24hr-format t)
(setq display-time-load-average t)
(display-time)

;; show column number
(column-number-mode t)

;; y/n hassle
(fset 'yes-or-no-p 'y-or-n-p)
