;; BASIC CUSTOMIZATION
;; -------------------------

(when window-system (set-frame-size (selected-frame) 85 40))

;(load-theme 'material t)
(load-theme 'wombat t)


(setq inhibit-startup-message t)  ;; disable start up screen
(setq initial-scratch-message "") ;; hide scratch buffer help

(global-linum-mode t)             ;; enable line numbers
;(menu-bar-mode -1)                ;;
(tool-bar-mode -1)                ;; 
(toggle-scroll-bar -1)            ;; 

;; note the visual warning causes problems on OS X
(setq ring-bell-function 'ignore) ;; disable audio/visual warning

(set-face-attribute 'default nil
  :family "Inconsolata" :height 180 :weight 'normal)
;; (set-face-attribute 'default nil
;;   :family "Monaco" :height 180 :weight 'normal)

(setq default-tab-width 4)         ;; use 4 because 8 is too wide

;; end of custom.el

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b825687675ea2644d1c017f246077cdd725d4326a1c11d84871308573d019f67"
     "82b67c7e21c3b12be7b569af7c84ec0fb2d62105629a173e2479e1053cff94bd"
     "c567c85efdb584afa78a1e45a6ca475f5b55f642dfcd6277050043a568d1ac6f"
     "e56ee322c8907feab796a1fb808ceadaab5caba5494a50ee83a13091d5b1a10c"
     "b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4"
     default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
