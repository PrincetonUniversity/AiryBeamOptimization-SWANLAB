function W = FocusedSteeringVector(freq,steer_angle,elemSpacing,numElems,focalRange)
    c =  physconst('LightSpeed');
    array = phased.ULA(numElems,elemSpacing);
    SV = phased.FocusedSteeringVector('SensorArray',array,'PropagationSpeed',c);
    W = SV(freq,[steer_angle;0],focalRange);
end