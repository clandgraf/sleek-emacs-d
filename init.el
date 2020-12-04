
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d2d2d" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#6699cc" "#d3d0c8"])
 '(ansi-term-color-vector
   [unspecified "#2d2d2d" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#6699cc" "#d3d0c8"] t)
 '(custom-safe-themes
   '("c0fcf9d1ba4c7dd37fd483962363b7fcedf223721ee1bf434826618dfcb6a20a" "24714e2cb4a9d6ec1335de295966906474fdb668429549416ed8636196cb1441" "f2c35f8562f6a1e5b3f4c543d5ff8f24100fae1da29aeb1864bbc17758f52b70" "5846b39f2171d620c45ee31409350c1ccaddebd3f88ac19894ae15db9ef23035" "c968804189e0fc963c641f5c9ad64bca431d41af2fb7e1d01a2a6666376f819c" "8c1dd3d6fdfb2bee6b8f05d13d167f200befe1712d0abfdc47bb6d3b706c3434" "b8929cff63ffc759e436b0f0575d15a8ad7658932f4b2c99415f3dde09b32e97" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "9be1d34d961a40d94ef94d0d08a364c3d27201f3c98c9d38e36f10588469ea57" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))
 '(package-selected-packages
   '(cmake-mode flycheck smartparens helm-projectile rjsx-mode diff-hl dracula-theme zenburn-theme monokai-pro-theme color-theme-sanityinc-solarized js2-mode processing-mode processing-snippets json-mode htmlize markdown-mode web-mode base16-theme rg rust-mode diminish smart-mode-line slime-company company projectile helm magit color-theme-sanityinc-tomorrow slime)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d/cla-conf")
(require 'cla-filehandling)
(require 'cla-gitlab)

(org-babel-load-file "~/.emacs.d/cla-conf/config.org")
