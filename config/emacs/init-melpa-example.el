;;; package -- Emacs main entry
;;;
;;; Commentary:
;;;   keeping the linter happy
;;;
;;; Code:
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
        (package-refresh-contents)
        (package-install 'use-package))


;; Rest of config is documented in org-mode format
(org-babel-load-file (expand-file-name "~/.config/emacs/myinit.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "4cbec5d41c8ca9742e7c31cc13d8d4d5a18bd3a0961c18eb56d69972bbcf3071" default)))
 '(line-number-mode nil)
 '(org-default-notes-file (concat org-directory "/notes.org"))
 '(org-directory "~/Documents/Notes/notes-org")
 '(org-export-html-postamble nil)
 '(org-hide-leading-stars t)
 '(org-startup-folded (quote overview))
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (prodigy origami dumb-jump ggtags elfeed-org elfeed-goodies elfeed shell-switcher default-text-scale magit ac-cider cider smartparens counsel-projectile auctex dired-quick-sort dired+ nodejs-repl tern-auto-complete tern js2-refactor ac-js2 js2-mode emmet-mode web-mode iedit expand-region hungry-delete beacon virtualenvwrapper elpy jedi flycheck htmlize ox-reveal powerline alect-themes eziam-theme moe-theme base16-theme color-theme counsel ace-window epresent noflet org-ac org-bullets which-key try writeroom-mode window-number use-package smooth-scroll purple-haze-theme project-explorer monokai-theme molokai-theme material-theme markdown-mode json-mode idea-darkula-theme helm-go-package go-snippets go-scratch go-projectile go-impl go-autocomplete evil-leader buffer-move))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
