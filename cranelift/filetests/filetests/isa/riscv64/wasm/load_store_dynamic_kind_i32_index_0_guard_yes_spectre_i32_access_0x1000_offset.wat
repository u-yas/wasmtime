;;! target = "riscv64"
;;!
;;! settings = ['enable_heap_access_spectre_mitigation=true']
;;!
;;! compile = true
;;!
;;! [globals.vmctx]
;;! type = "i64"
;;! vmctx = true
;;!
;;! [globals.heap_base]
;;! type = "i64"
;;! load = { base = "vmctx", offset = 0, readonly = true }
;;!
;;! [globals.heap_bound]
;;! type = "i64"
;;! load = { base = "vmctx", offset = 8, readonly = true }
;;!
;;! [[heaps]]
;;! base = "heap_base"
;;! min_size = 0x10000
;;! offset_guard_size = 0
;;! index_type = "i32"
;;! style = { kind = "dynamic", bound = "heap_bound" }

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i32 1)

  (func (export "do_store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store offset=0x1000)

  (func (export "do_load") (param i32) (result i32)
    local.get 0
    i32.load offset=0x1000))

;; function u0:0:
;; block0:
;;   slli t2,a0,32
;;   srli a3,t2,32
;;   ld a0,8(a2)
;;   lui a4,1048575
;;   addi a4,a4,4092
;;   add a0,a0,a4
;;   ld a2,0(a2)
;;   add a2,a2,a3
;;   lui a4,1
;;   add a2,a2,a4
;;   li a4,0
;;   ugt a0,a3,a0##ty=i64
;;   selectif_spectre_guard a3,a4,a2##test=a0
;;   sw a1,0(a3)
;;   j label1
;; block1:
;;   ret
;;
;; function u0:1:
;; block0:
;;   slli t2,a0,32
;;   srli a2,t2,32
;;   ld a0,8(a1)
;;   lui a3,1048575
;;   addi a3,a3,4092
;;   add a0,a0,a3
;;   ld a1,0(a1)
;;   add a1,a1,a2
;;   lui a3,1
;;   add a1,a1,a3
;;   li a3,0
;;   ugt a0,a2,a0##ty=i64
;;   selectif_spectre_guard a2,a3,a1##test=a0
;;   lw a0,0(a2)
;;   j label1
;; block1:
;;   ret