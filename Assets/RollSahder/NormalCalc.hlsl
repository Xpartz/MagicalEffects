
void NormalVector_half(float3 Vert, float3 Norm, float AnglePerUnit, float UnrolledAngle, out float3 NormalOut) {

          float fromStart =   Vert.z * AnglePerUnit;               
                if (fromStart < UnrolledAngle) {                         
                           NormalOut =  float3(0, 1, 0);
                        }
                        else {
                            float shifted = fromStart - UnrolledAngle;
                            NormalOut = float3(0, cos(shifted),-sin(shifted));
                        }

          
	
}