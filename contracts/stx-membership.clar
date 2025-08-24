;; stx-membership.clar
;; A simple STX-based membership contract

(define-constant ERR-NOT-MEMBER (err u100))
(define-constant ERR-FAILED-TRANSFER (err u101))

;; Membership fee (in microSTX, e.g., 10 STX = 10_000_000)
(define-constant membership-fee u10000000)

;; Membership duration (number of blocks, e.g., ~1 day = 144 blocks)
(define-constant membership-duration u144)

;; Admin (contract deployer)
(define-constant contract-admin tx-sender)

;; Store member info: expiry block
(define-map members { user: principal } { expiry: uint })

;; -----------------------------
;; FUNCTIONS
;; -----------------------------

;; Join membership (pay fee)
(define-public (join)
  (let ((amount membership-fee))
    ;; transfer STX fee into contract
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))

    ;; set/renew membership expiry
    (let ((current-block stacks-block-height))
      (map-set members { user: tx-sender }
        { expiry: (+ current-block membership-duration) })
    )
    (ok "Membership activated")
  )
)

;; Renew membership (same as join)
(define-public (renew)
  (join)
)

;; Check if user is a valid member
(define-read-only (is-member (user principal))
  (let ((member-opt (map-get? members { user: user })))
    (if (is-some member-opt)
      (ok (>= (get expiry (unwrap-panic member-opt)) stacks-block-height))
      (err u404)
    )
  )
)

;; Get membership expiry block
(define-read-only (get-expiry (user principal))
  (map-get? members { user: user })
)
