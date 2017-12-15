;;; -*- lexical-binding: t -*-
(add-hook 'after-init-hook 'ivy-mode)
(after-load 'ivy
  (setq-default ivy-use-virtual-buffers t
                ivy-virtual-abbreviate 'fullpath
                ivy-count-format ""
                projectile-completion-system 'ivy
                ivy-magic-tilde nil
                ivy-initial-inputs-alist
                '((man . "^")
                  (woman . "^")))

  ;; IDO-style directory navigation
  (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)
  (dolist (k '("C-j" "C-RET"))
    (define-key ivy-minibuffer-map (kbd k) #'ivy-immediate-done))

  (define-key ivy-minibuffer-map (kbd "<up>") #'ivy-previous-line-or-history)


  (defun sanityinc/enable-ivy-flx-matching ()
    "Make `ivy' matching work more like IDO."
    (interactive)
    (require-package 'flx)
    (setq-default ivy-re-builders-alist
                  '((t . ivy--regex-fuzzy))))

  (defun sanityinc/swiper-at-point (sym)
    "Use `swiper' to search for the symbol at point."
    (interactive (list (thing-at-point 'symbol)))
    (swiper sym))

  (define-key ivy-mode-map (kbd "M-s /") 'sanityinc/swiper-at-point))


(when (maybe-require-package 'ivy-historian)
  (add-hook 'after-init-hook (lambda () (ivy-historian-mode t))))

(setq-default counsel-mode-override-describe-bindings t)
(add-hook 'after-init-hook 'counsel-mode)



;; (global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)


(when (and (executable-find "ag")
           (maybe-require-package 'ag))
    (global-set-key (kbd "M-?") 'counsel-ag))

(provide 'init-ivy)
