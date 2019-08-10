
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(package-selected-packages
   (quote
    (diminish smart-mode-line slime-company company projectile helm magit color-theme-sanityinc-tomorrow slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ~~~~~~~~~~~~~~~~~~
;; package.el
;; ~~~~~~~~~~~~~~~~~~

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-refresh-contents)

(defun cla/install-from-elpa (package)
  (unless (package-installed-p package)
    (package-install package)))

(defun cla/install-from-url (url path)
  (unless (file-exists-p path)
    (url-copy-file url path)))

;; ~~~~~~~~~~~~~~~
;; General Setup
;; ~~~~~~~~~~~~~~~

(setq visible-bell nil
      ring-bell-function 'flash-mode-line)
(defun flash-mode-line ()
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil #'invert-face 'mode-line))

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(add-hook 'before-save-hook         ; on save remove trailing whitespace
          'delete-trailing-whitespace)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode 0)
(windmove-default-keybindings 'meta)
(global-set-key (kbd "M-SPC") 'set-mark-command)
(setq inhibit-startup-screen t)
(global-hl-line-mode 1)

;; Set window keys
(global-set-key (kbd "S-M-<up>") 'enlarge-window)
(global-set-key (kbd "S-M-<down>") 'shrink-window)
(global-set-key (kbd "S-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-M-<right>") 'enlarge-window-horizontally)
;;(global-set-key (kbd "<mouse-4>") 'cla/switch-to-other-buffer)
(global-set-key (kbd "C-<tab>") 'cla/switch-to-other-buffer)
(global-set-key (kbd "H-<left>") 'previous-buffer)
(global-set-key (kbd "H-<right>") 'next-buffer)
(global-set-key (kbd "<triple-wheel-right>") 'previous-buffer)
(global-set-key (kbd "<triple-wheel-left>") 'next-buffer)
(global-set-key (kbd "H-<tab>") 'other-frame)

(defun cla/back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (progn (back-to-indentation) (point)))
      (beginning-of-line)))

(global-set-key (kbd "C-a") 'cla/back-to-indentation-or-beginning)
(global-set-key (kbd "<home>") 'cla/back-to-indentation-or-beginning)

(defvar cla-custom-font-height 100)
(defun cla-set-default-font ()
  (interactive)
  (set-face-attribute 'default nil
                      :family "Source Code Pro" :height cla-custom-font-height))
(global-set-key (kbd "H-f 1") 'cla-set-default-font)

(defvar cla-custom-large-font-height 110)
(defun cla-set-large-font ()
  (interactive)
  (set-face-attribute 'default nil
                      :family "Source Code Pro" :height cla-custom-large-font-height))
(global-set-key (kbd "H-f 2") 'cla-set-large-font)

(cla-set-default-font)

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

;; ~~~~~~~~~
;; Diminish
;; ~~~~~~~~~

(cla/install-from-elpa 'diminish)
(add-hook 'after-init-hook (lambda ()
                             (diminish 'company-mode)
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
(cla/install-from-elpa 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-eighties)
