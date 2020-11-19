;;; package --- Summary
;;; Commentary:
;;; Code:

(defun cla/--get-relevant-file ()
  "Return the relevant file for current buffer."
  (if (equal major-mode 'dired-mode)
      default-directory
    (buffer-file-name)))

(defmacro cla/with-relevant-file (file-name &rest body)
  "Execute BODY with current buffer's relevant file bound to FILE-NAME."
  (declare (indent 1))
  `(let ((,file-name (cla/--get-relevant-file)))
     (if (null ,file-name)
         (message "No file available.")
       ,@body)))

(defun cla/win-path-to-wsl-path (file-name)
  "Convert FILE-NAME to WSL Path using wsl and wslpath."
  (let ((output (substring (shell-command-to-string (format "wsl wslpath %s" file-name))
                           0 -1)))
    (if (string-prefix-p "wslpath: " output)
        (progn
          (message "No WSL representation for %s." file-name)
          nil)
      output)))

(cond

 ((equal system-type 'windows-nt)
  (defun cla/file-browser-command (file-name)
    "Use Windows Explorer to open FILE-NAME"
    (let ((is-directory (directory-name-p file-name))
          (path (replace-regexp-in-string "/" "\\" file-name t t)))
      (shell-command
       (if is-directory
           (format "explorer %s" path)
         (format "explorer /select,%s" path))))))

 ((equal system-type 'darwin)
  (defun cla/file-browser-command (file-name)
    "Use Finder to open FILE-NAME."
    (shell-command (format "open -a Finder %s" file-name))))

 (t
  (defun cla/file-browser-command (file-name)
    "No File Browser available to open FILE-NAME."
    (message "No command for opening files"))))

(defun cla/copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (cla/with-relevant-file f
    (kill-new f)
    (message "Copied buffer file name '%s' to the clipboard." f)))

(defun cla/copy-wsl-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (cla/with-relevant-file f
    (let ((wsl-filename (cla/win-path-to-wsl-path f)))
      ;; wslpath may fail if file does not exist??
      (kill-new wsl-filename)
      (message "Copied buffer file name '%s' to the clipboard." wsl-filename))))

(defun cla/open-buffer-path ()
  "Run explorer on the directory of the current buffer."
  (interactive)
  (cla/with-relevant-file f
    (cla/file-browser-command f)))

(global-set-key (kbd "<f6>") 'cla/copy-file-name-to-clipboard)
(global-set-key (kbd "C-<f6>") 'cla/copy-wsl-file-name-to-clipboard)
(global-set-key (kbd "<f7>") 'cla/open-buffer-path)

(provide 'cla-filehandling)
;;; cla-filehandling.el ends here
