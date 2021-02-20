
(defun wsl/is-wsl ()
  (getenv "WSL_DISTRO_NAME"))

(defun wsl/region-to-clip-exe ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "clip.exe"))

(when (wsl/is-wsl)
  (global-set-key (kbd "<f9>") 'wsl/region-to-clip-exe))

(provide 'wsl)
