(require-package 'rtags)
(require-package 'ac-rtags)
(require-package 'flycheck-rtags)
;; git clone --recursive https://github.com/Andersbakken/rtags.git
;; cd rtags
;; mkdir build
;; cd build
;; cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..
;; make
;; sudo make install

(defun delete-buffer-and-window (buffer-name)
  "Delete buffer and window that special.
Argument BUFFER-NAME the buffer name that will delete."
  (interactive)
  (if (bufferp (get-buffer buffer-name))
      (progn
        (delete-buffer-window buffer-name)
        (kill-buffer (get-buffer buffer-name)))
    (message "Buffer %s is not exist." buffer-name)))

(defun delete-current-buffer-and-window ()
  "Delete current buffer and window."
  (interactive)
  (delete-buffer-and-window (buffer-name)))

(defun delete-buffer-window (buffer-name)
  "Delete the window of special buffer.
Argument BUFFER-NAME the buffer name that will delete."
  (interactive)
  (if (bufferp (get-buffer buffer-name))
      (delete-window (get-buffer-window (get-buffer buffer-name)))
    (message "Buffer %s is not exist." buffer-name)))

(dolist (hook (list
               'c-mode-hook
               'c++-mode-hook))

  ;; Run rtags daemon to provide tags request service.
  (rtags-start-process-unless-running)

  ;; Just kill window and buffer, don't break stack position.
  (setq rtags-bury-buffer-function 'delete-current-buffer-and-window)

  ;; Split window force at below.
  (setq rtags-split-window-function 'split-window-below)

  ;; Flycheck setup.
  ;; (flycheck-select-checker 'rtags)
  (setq flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq flycheck-check-syntax-automatically nil)


  ;; If your project is build with cmake,
  ;; you need use command "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ." to generate file `compile_commands.json'
  ;; then use command "rc -J json_file" to index C/C++ project tag index.
  ;;
  ;; If your project is build with qmake,
  ;; you need use command "bear --append make" to generate `compile_commands.json' file after command "qmake .."
  ;; then use command "rc -J json_file" to index C/C++ project tag index.
  (defun rtags-find-references-at-point+ ()
    (interactive)
    (rtags-find-references-at-point)
    ;; Switch window after poup rtag window.
    (other-window 1)
    )
  )

(provide 'init-rtags)
