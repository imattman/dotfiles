;; Mattman's emacs config
;; -------------------------

;(when window-system (set-frame-size (selected-frame) 85 40))

(load-theme 'deeper-blue t)
;(load-theme 'wombat t)

(setq inhibit-startup-message t)  ;; disable start up screen
(menu-bar-mode -1)                ;;
(tool-bar-mode -1)                ;; 
(toggle-scroll-bar -1)            ;; 

(global-linum-mode t)             ;; enable line numbers
(setq default-tab-width 4)        ;; use 4 because 8 is too wide

(setq initial-scratch-message "") ;; hide scratch buffer help


;; note the visual warning causes problems on OS X
(setq ring-bell-function 'ignore) ;; disable audio/visual warning

;(print (font-family-list))
(set-face-attribute 'default nil
  :family "Hack Nerd Font" :height 160 :weight 'normal)
;  :family "FiraCode Nerd Font" :height 160 :weight 'normal)

