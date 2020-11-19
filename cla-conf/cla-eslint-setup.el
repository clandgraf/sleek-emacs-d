(require 'cla-util-fs)

;; Setup flycheck to use local eslint checker
; (defvar npm/root-indicator "package.json")

(defun npm/executable-name (name)
  "Return a platform specific version of npm executable NAME."
  (if (equal system-type 'windows-nt)
      (concat name ".cmd")
    name))

(defconst npm/eslint-executable
  (concat "*/node_modules/.bin/" (npm/executable-name "eslint")))

(defun npm/use-local-eslint ()
  "Search for eslint in a dominating instance directory."
  (let* ((eslint-conf (cla/locate-dominating-name-n '(".eslintrc.json"
                                                      "package_sources/cs.web/.eslintrc.json")))
         (eslint-conf-dir (and eslint-conf (file-name-directory eslint-conf)))
         (eslint-executable (cla/locate-dominating-glob-first npm/eslint-executable)))
    (when eslint-executable
      (setq-local flycheck-javascript-eslint-executable eslint-executable))))
