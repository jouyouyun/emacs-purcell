;;; 'wen-python.el' --- Emacs python selection.

(require-package 'python)
(require-package 'pyenv-mode)
(require-package 'elpy)
(require-package 'jedi-core)
(require-package 'company-jedi)

(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")

;; elpy
;; depends: jedi, flake8, importmagic, autopep8, yapf
;; query config 'M-x elpy-config'
;; pyvenv: active virtualenv 'M-x pyvenv-activate'
;; deactive 'M-x pyvenv-deactivate'
(defun wen-elpy-setup()
  (elpy-enable)
  (setq elpy-rpc-backend "jedi")
  (setq elpy-rpc-python-command "python")
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  )

(eval-after-load "python"
  `(progn
     (wen-elpy-setup)
     (add-hook 'python-mode-hook 'eldoc-mode)
     ;; Standard Jedi.el setting
                                        ;(add-hook 'python-mode-hook 'jedi:setup)
                                        ;(setq jedi:complete-on-dot t)
     (add-to-list 'company-backends 'company-jedi)
     ))

(provide 'init-python)
