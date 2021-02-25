
;; TODO skip when frame is not in tmux context
;; TODO Issue when going down --> minibuffer

(defun tmux/tmux-frame-p ()
  (getenv "TMUX" (selected-frame)))

(defmacro if-error (form cond &rest body)
  (declare (indent 2))
  `(unless (or (ignore-errors ,form t) (not ,cond))
     ,@body))

(defmacro tmux/--windmove-or-select-pane (windmove-dir tmux-dir)
  `(if-error (,(intern (format "windmove-%s" windmove-dir))) (tmux/tmux-frame-p)
     (shell-command ,(format "tmux select-pane %s" tmux-dir))
     (message "tmux select-pane")))

(defun tmux/windmove-left ()
  (interactive)
  (tmux/--windmove-or-select-pane "left" "-L"))

(defun tmux/windmove-right ()
  (interactive)
  (tmux/--windmove-or-select-pane "right" "-R"))

(defun tmux/windmove-up ()
  (interactive)
  (tmux/--windmove-or-select-pane "up" "-U"))

(defun tmux/windmove-down ()
  (interactive)
  (tmux/--windmove-or-select-pane "down" "-D"))

(defun tmux/windmove-meta-binding ()
  (global-set-key (kbd "M-<left>") 'tmux/windmove-left)
  (global-set-key (kbd "M-<right>") 'tmux/windmove-right)
  (global-set-key (kbd "M-<up>") 'tmux/windmove-up)
  (global-set-key (kbd "M-<down>") 'tmux/windmove-down))

(provide 'tmux-windmove)
