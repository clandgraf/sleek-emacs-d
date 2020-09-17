
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d2d2d" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#6699cc" "#d3d0c8"])
 '(ansi-term-color-vector
   [unspecified "#2d2d2d" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#6699cc" "#d3d0c8"])
 '(custom-safe-themes
   '("24714e2cb4a9d6ec1335de295966906474fdb668429549416ed8636196cb1441" "f2c35f8562f6a1e5b3f4c543d5ff8f24100fae1da29aeb1864bbc17758f52b70" "5846b39f2171d620c45ee31409350c1ccaddebd3f88ac19894ae15db9ef23035" "c968804189e0fc963c641f5c9ad64bca431d41af2fb7e1d01a2a6666376f819c" "8c1dd3d6fdfb2bee6b8f05d13d167f200befe1712d0abfdc47bb6d3b706c3434" "b8929cff63ffc759e436b0f0575d15a8ad7658932f4b2c99415f3dde09b32e97" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "9be1d34d961a40d94ef94d0d08a364c3d27201f3c98c9d38e36f10588469ea57" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))
 '(package-selected-packages
   '(diff-hl dracula-theme zenburn-theme monokai-pro-theme color-theme-sanityinc-solarized js2-mode processing-mode processing-snippets json-mode htmlize markdown-mode web-mode base16-theme rg rust-mode diminish smart-mode-line slime-company company projectile helm magit color-theme-sanityinc-tomorrow slime)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(org-babel-load-file "~/.emacs.d/config.org")

;; markdown-mode

(cla/install-from-elpa 'markdown-mode)


;; ~~~~~~~~~~~~~~~~~~~
;; processing
;; ~~~~~~~~~~~~~~~~~~~

(setq processing-location
      "c:/Users/chris/processing-3.5.3/processing-java.exe")
(setq processing-application-dir
      "c:/Users/chris/processing-3.5.3")
(setq processing-sketchbook-dir
      "c:/Users/chris/Documents/Processing")

;; ~~~~~~~~~~~~~~~~~~~
;; magit - git with a vengeance
;; ~~~~~~~~~~~~~~~~~~~

(cla/install-from-elpa 'magit)

;; ~~~~~~~~~~~~~~~~~~~
;; company-mode
;; ~~~~~~~~~~~~~~~~~~~

(cla/install-from-elpa 'company)
(setq company-dabbrev-downcase nil)
(setq company-minimum-prefix-length 2)
(setq company-idle-delay 0)
(add-hook 'after-init-hook 'global-company-mode)

;; ~~~~~~~~~~~~~~~~~~~
;; slime
;; ~~~~~~~~~~~~~~~~~~~

(cla/install-from-elpa 'slime)
(cla/install-from-elpa 'slime-company)
(setq inferior-lisp-program "/data/data/com.termux/files/home/ecl/bin/ecl")
(setq slime-contribs '(slime-fancy slime-company))

;; ~~~~~~~~~~~~~~~~~~~
;; projectile
;; ~~~~~~~~~~~~~~~~~~~

(cla/install-from-elpa 'projectile)
(projectile-global-mode)
(global-set-key (kbd "H-p H-f") 'projectile-find-file)
(global-set-key (kbd "H-p H-g") 'projectile-grep)
(global-set-key (kbd "H-p H-s") 'projectile-switch-project)
(global-set-key (kbd "H-p H-k") 'projectile-kill-buffers)

;; ~~~~~~~~~~~~~~~~~~
;; helm
;; ~~~~~~~~~~~~~~~~~~

(cla/install-from-elpa 'helm)
(require 'helm-config)
(helm-mode 1)
(setq helm-split-window-in-side-p t)
(setq helm-split-window-default-side 'below)
(with-eval-after-load "helm-config"
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (define-key helm-find-files-map "\t" 'helm-execute-persistent-action)
  (define-key helm-read-file-map "\t" 'helm-execute-persistent-action))

;; ~~~~~~~~~~~~~~~~~~
;; diff-hl
;; ~~~~~~~~~~~~~~~~~~

(cla/install-from-elpa 'diff-hl)
(global-diff-hl-mode)

;; ~~~~~~~~~
;; Diminish
;; ~~~~~~~~~

(cla/install-from-elpa 'diminish)
(add-hook 'after-init-hook (lambda ()
                             (diminish 'company-mode)
                             (diminish 'global-company-mode)
                             (diminish 'helm-mode)
                             (diminish 'smartparens-mode)))

;; ~~~~~~~~~~~~~~~~~~~
;;  smart-mode-line
;; ~~~~~~~~~~~~~~~~~~~

(cla/install-from-elpa 'smart-mode-line)
(setq sml/theme 'respectful)
(sml/setup)

;; ~~~~~~~~~~~~~~~~~~~

(put 'dired-find-alternate-file 'disabled nil)
(cla/install-from-elpa 'dracula-theme)
(load-theme 'dracula)
