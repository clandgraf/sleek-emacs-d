(defun cla/get-relevant-file ()
  "Return the relevant file for current buffer."
  (if (equal major-mode 'dired-mode)
      default-directory
    (buffer-file-name)))

(defmacro cla/with-relevant-file (file-name &rest body)
  "Execute BODY with current buffer's relevant file bound to FILE-NAME."
  (declare (indent 1))
  `(let ((,file-name (cla/get-relevant-file)))
     (if (null ,file-name)
         (message "No file available.")
       ,@body)))

(defun cla/locate-dominating-name (name &optional file)
  (let* ((f (or file (cla/get-relevant-file)))
         (prefix (locate-dominating-file f name)))
    (and prefix
         (concat prefix name))))

(defun cla/locate-dominating-name-n (names &optional file)
  (let ((f (or file (cla/get-relevant-file))))
    (--some (cla/locate-dominating-name it f) names)))

(defun cla/locate-dominating-glob (glob &optional directory return-dir)
  "Find files matching GLOB in parent directories.
If RETURN-DIR is set returns directory in which match was found,
else returns matched files.  If DIRECTORY is provided, start
search from here, else use current 'buffer-file-name'."
  (let* ((d1 (or directory
                 buffer-file-name))
         (d (if d1
                (file-name-directory d1)
              nil)))
    (if (string= d d1) ; No parent directory for d1
        nil
      (let ((files (file-expand-wildcards (expand-file-name glob d))))
        (if files
            ;; Found match
            (if return-dir
                d
              files)
          ;; Search in parent directory
          (cla/locate-dominating-glob glob
                                      (directory-file-name d)
                                      return-dir))))))

(defun cla/locate-dominating-glob-n (globs &optional directory)
  (let ((f (or directory (cla/get-relevant-file))))
    (--some (cla/locate-dominating-glob it f) globs)))


(defun cla/locate-dominating-glob-first (glob &optional directory)
  "Like 'cla/locate-dominating-files', but return only first match.
GLOB is a Unix glob.  If DIRECTORY is provided, start search from
here, else use current 'buffer-file-name'."
  (car (cla/locate-dominating-glob glob directory)))

(provide 'cla-util-fs)
