 
    SUBROUTINE calcmdefect_ml_rs(ibnd0,ibnd,ik0,ik)
    USE cell_base,       ONLY : alat, ibrav, omega, at, bg, celldm, wmass
    INTEGER :: ibnd, ik, ik0,ibnd0
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !ml=0
    
    !            IF( nks > 1 ) CALL get_buffer (evc, nwordwfc, iunwfc, ik )
    
    !     npw = ngk(ik)
    !            CALL init_us_2 (npw, igk_k(1,ik), xk (1, ik), vkb)
    !            CALL calbec ( npw, vkb, evc, becp )
    
    !        CALL get_buffer ( evc1, nwordwfc, iunwfc, ik0 )
    !        CALL get_buffer ( evc2, nwordwfc, iunwfc, ik )
    !!!!!!!!!!!!write (*,*) "size evc evc1:" , size(evc),size(evc1)
    !!!!!!!!!!!!!!! evc
    
    
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!! vl in real super2prim, module
    auxr(:) =  vrs(:,1)
    psiprod(:)=0.00
    vgk_perturb(:)=0.00
    ml=0
    psicprod=0
    psicprod1=0
    !mltot=0
    !mltot1=0
    d1=((1.0/dffts%nr1*at(1,1))*(xk(1,ik)-xk(1,ik0)) +&
        (1.0/dffts%nr1*at(2,1))*(xk(2,ik)-xk(2,ik0)) +&
        (1.0/dffts%nr1*at(3,1))*(xk(3,ik)-xk(3,ik0)) )*tpi 
    d2=((1.0/dffts%nr2*at(1,2))*(xk(1,ik)-xk(1,ik0)) +&
        (1.0/dffts%nr2*at(2,2))*(xk(2,ik)-xk(2,ik0)) +&
        (1.0/dffts%nr2*at(3,2))*(xk(3,ik)-xk(3,ik0)) )*tpi 
    d3=((1.0/dffts%nr3*at(1,3))*(xk(1,ik)-xk(1,ik0)) +&
        (1.0/dffts%nr3*at(2,3))*(xk(2,ik)-xk(2,ik0)) +&
        (1.0/dffts%nr3*at(3,3))*(xk(3,ik)-xk(3,ik0)) )*tpi 
    
    psic2(1:dffts%nnr) = (0.d0,0.d0)
    psic1(1:dffts%nnr) = (0.d0,0.d0)
    DO ig = 1, ngk(ikk)
       psic2 (dffts%nl (igk_k(ig,ikk) ) ) = evc2 (ig, ibnd)
    ENDDO
    DO ig = 1, ngk(ik0)
       psic1 (dffts%nl (igk_k(ig,ik0) ) ) = evc1 (ig, ibnd0)
    ENDDO
    CALL invfft ('Wave', psic2, dffts)
    CALL invfft ('Wave', psic1, dffts)
    
    
    
    !d1=((1.0/nr1_perturb*at_perturb(1,1))*(xk(1,ik)-xk(1,ik0)) +&
    !    (1.0/nr1_perturb*at_perturb(2,1))*(xk(2,ik)-xk(2,ik0)) +&
    !    (1.0/nr1_perturb*at_perturb(3,1))*(xk(3,ik)-xk(3,ik0)) )*tpi 
    !d2=((1.0/nr2_perturb*at_perturb(1,2))*(xk(1,ik)-xk(1,ik0)) +&
    !    (1.0/nr2_perturb*at_perturb(2,2))*(xk(2,ik)-xk(2,ik0)) +&
    !    (1.0/nr2_perturb*at_perturb(3,2))*(xk(3,ik)-xk(3,ik0)) )*tpi 
    !d3=((1.0/nr3_perturb*at_perturb(1,3))*(xk(1,ik)-xk(1,ik0)) +&
    !    (1.0/nr3_perturb*at_perturb(2,3))*(xk(2,ik)-xk(2,ik0)) +&
    !    (1.0/nr3_perturb*at_perturb(3,3))*(xk(3,ik)-xk(3,ik0)) )*tpi 
    !
    arg=0
    inr=0
!    write(*,*) 'xk-xk01',xk(1,ik)-xk(1,ik0)
!    write(*,*) 'xk-xk02',xk(2,ik)-xk(2,ik0)
!    write(*,*) 'xk-xk03',xk(3,ik)-xk(3,ik0)
    do irz =0, nr3_perturb-1
    ir3mod=irz-(irz/(dffts%nr3))*dffts%nr3
    do iry =0, nr2_perturb-1
    ir2mod=iry-(iry/(dffts%nr2))*dffts%nr2
    do irx =0, nr1_perturb-1
    ir1mod=irx-(irx/(dffts%nr1))*dffts%nr1
    !arg=tpi*(real(irx)/nr1_perturb*at_perturb(1,1)+real(iry)/nr2_perturb*at_perturb(1,2)&
    !                                              +real(irz)/nr3_perturb*at_perturb(1,3))*(xk(1,ik)-xk(1,ik0)) +&
    !    tpi*(real(irx)/nr1_perturb*at_perturb(2,1)+real(iry)/nr2_perturb*at_perturb(2,2)&
    !                                              +real(irz)/nr3_perturb*at_perturb(2,3))*(xk(2,ik)-xk(2,ik0)) +&
    !    tpi*(real(irx)/nr1_perturb*at_perturb(3,1)+real(iry)/nr2_perturb*at_perturb(3,2)&
    !                                              +real(irz)/nr3_perturb*at_perturb(3,3))*(xk(3,ik)-xk(3,ik0))   
    
    arg=irz*d3+iry*d2+irx*d1
    !!!!!!!!!!!!!!!!!!!!!!!!!!!
    !move vloc center 
    !!!!!!!!!!!!!!!!!!!!!!!!!!!
    !arg=ir3mod*d3+ir2mod*d2+ir1mod*d1
    
    arg=tpi*(real(irx)/dffts%nr1*at(1,1)+real(iry)/dffts%nr2*at(1,2)+real(irz)/dffts%nr3*at(1,3))*(xk(1,ik)-xk(1,ik0)) +&
        tpi*(real(irx)/dffts%nr1*at(2,1)+real(iry)/dffts%nr2*at(2,2)+real(irz)/dffts%nr3*at(2,3))*(xk(2,ik)-xk(2,ik0)) +&
        tpi*(real(irx)/dffts%nr1*at(3,1)+real(iry)/dffts%nr2*at(3,2)+real(irz)/dffts%nr3*at(3,3))*(xk(3,ik)-xk(3,ik0))   
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ! shift arg center
    arg=irz*d3+(iry-iry/(nr2_perturb/2+1)*nr2_perturb)*d2+(irx-irx/(nr1_perturb/2+1)*nr1_perturb)*d1
    !arg=irz*d3+(iry-iry/(dffts%nr2/2+1)*dffts%nr1)*d2+(irx-irx/(dffts%nr1/2+1)*dffts%nr1)*d1
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !arg=irz*d3+iry*d2+irx*d1
    
    phase=CMPLX(COS(arg),SIN(arg),kind=dp)
    inr=inr+1
    irnmod=(ir3mod)*dffts%nr1*dffts%nr2+(ir2mod)*dffts%nr1+ir1mod+1
    ml=ml+CONJG(psic1(irnmod))*psic2(irnmod)*plot_perturb(inr)*phase
    psicprod=psicprod+CONJG(psic1(irnmod))*psic2(irnmod)*phase
    psicprod1=psicprod1+CONJG(psic1(irnmod))*psic2(irnmod)
    !ml2=ml2+CONJG(psic1(irnmod))*psic2(irnmod)*plot_perturb(inr)*phase
    !mltot=mltot+CONJG(psic1(irnmod))*psic2(irnmod)*phase
    !mltot1=mltot1+CONJG(psic1(irnmod))*psic2(irnmod)
    !write (*,*) 'iri',ir1mod,ir2mod,ir3mod
    !write (*,*) 'grid ', irnmod
    !write (*,*) 'psic1 ', psic1(irnmod)
    !write (*,*) 'psic2 ', psic2(irnmod)
    !write (*,*) 'arg', arg
    
    if ( irnmod<0 .or. irnmod>dffts%nnr ) then
       write (*,*) 'grid mismatch', irnmod, dffts%nnr 
    endif
    
    
    if (irz==dffts%nr3/2) then
            argt= atan2(real(CONJG(psic1(irnmod))*psic2(irnmod)*phase),aimag(CONJG(psic1(irnmod))*psic2(irnmod)*phase))
            argt2= atan2(real(CONJG(psic1(irnmod))*psic2(irnmod)),aimag(CONJG(psic1(irnmod))*psic2(irnmod)))
            if (argt<0) argt=argt+tpi
!            if (argt2<0) argt2=argt2+tpi
!    write(*,*) 'psiplts ik',ik, 'xyz', irx,iry,irz,  'psi1', psic1(irnmod),abs( psic1(irnmod)),  'psi2', &
!                        psic2(irnmod),abs(psic2(irnmod)),&
!   'arg', arg,'prod', CONJG(psic1(irnmod))*psic2(irnmod)*phase, abs(CONJG(psic1(irnmod))*psic2(irnmod)*phase),argt,argt2,&
!            real(CONJG(psic1(irnmod))*psic2(irnmod)),aimag(CONJG(psic1(irnmod))*psic2(irnmod)), psicprod1
    endif

       
    enddo
    enddo
    enddo
    
    !ml=ml/nr1_perturb/nr2_perturb/nr3_perturb
    ml=ml/dffts%nnr
    psicprod=psicprod/nr1_perturb/nr2_perturb/nr3_perturb
    psicprod1=psicprod1/nr1_perturb/nr2_perturb/nr3_perturb
    !psicprod=psicprod/dffts%nnr

!    write(*,*) 'psicprods', psicprod , abs(psicprod), abs(psicprod1)

    !write (*,*) 'ml super to primitive ki->kf',ik0,ik, ml, abs(ml), log(ml)
    !write (*,*) 'mlpsi*psi0 to primitive ki->kf',ik0,ik, mltot1, abs(mltot1), log(mltot1)
    !write (*,*) 'mlpsi*psi0*phase to primitive ki->kf',ik0,ik, mltot, abs(mltot), log(mltot)
    !write (*,*) 'modml super  ki->kf',ik0,ik, abs(ml)
    !write (*,*) 'Ml ki->kf ',ik0,ik, ml, abs(ml)
    write (*,1001) 'Ml ki->kf ',ik0,ik, xk(:,ik0),xk(:,ik), ml, abs(ml)
1001 format(A,I9,I9,3F14.9,3F14.9," ( ",e17.9," , ",e17.9," ) ",e17.9)
    !write(*,*) 'nrx_perturb',nr1_perturb,nr2_perturb,nr3_perturb
    !write(*,*) 'nrx_perturb',at,at_perturb, alat
    !write (*,*) 'dvgk', vgk(:)-vgk_perturb(:)
    !write (*,*) 'vgk', vgk(:)
    !write (*,*) 'vgk_perturb', vgk_perturb(:)
    !write (*,*) 'sum dvgk', sum(vgk(:)-vgk_perturb(:))
    !write(*,*) 'xk(ik)', xk(:,ik),ik
    !write(*,*) 'xk(ik0)', xk(:,ik0),ik0
    
    
    
    END SUBROUTINE calcmdefect_ml_rs

