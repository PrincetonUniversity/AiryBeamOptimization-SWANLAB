function RX_idx = RX_pos(RX_info,Y,Z)
    rxLoc = RX_info(1:2);
    rx_width = RX_info(3);
    rx_height = RX_info(4);
    [~, rx_zstart] = min(abs((rxLoc(2) - rx_width/2)- Z));
    [~, rx_zend] = min(abs((rxLoc(2) + rx_width/2)- Z)) ;
    [~, rx_ystart] = min(abs((rxLoc(1) - rx_height/2)- Y));
    [~, rx_yend] = min(abs((rxLoc(1) + rx_height/2)- Y)) ;
    RX_idx = [rx_ystart,rx_yend,rx_zstart,rx_zend];
    if(rx_zstart == 1)
        disp('Warning, RX placed at exact location of Array')
    end
end