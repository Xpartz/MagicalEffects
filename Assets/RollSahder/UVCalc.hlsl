float arcLengthToAngleUV_half(float angle, float _Pitch) {
                        float radical = sqrt(angle * angle + 1.0f);
                        
                        return _Pitch * 0.5f * (angle * radical + log(angle + radical));
                    }


void UVCalcF_half(float3 Vert, float StartAngle, float AnglePerUnit, float UnrolledAngle, float2 uv, float Pitch, out float2 UVxOut) {

          float fromStart =   Vert.z * AnglePerUnit;

                float fromOrigin = StartAngle - fromStart;
                float lengthToHere = arcLengthToAngleUV_half(fromOrigin,Pitch);
                float lengthToStart = arcLengthToAngleUV_half(StartAngle,Pitch);

                 UVxOut = lengthToStart - lengthToHere;

                 
                if (fromStart < UnrolledAngle) {
                            float lengthToSplit = arcLengthToAngleUV_half(StartAngle - UnrolledAngle,Pitch);
                            Vert.z = lengthToSplit - lengthToHere;
                            Vert.y = Vert.y;
                          
                        }
                        else {
                            float radiusAtSplit = Pitch * (StartAngle - UnrolledAngle);
                            float radius = Pitch * fromOrigin;

                            float shifted = fromStart - UnrolledAngle;

                            Vert.y = Vert.y + (radiusAtSplit - cos(shifted) * radius);
                            Vert.z += sin(shifted) * radius;

                            
                        }

            //float _Pitch = arcLengthToAngle_half;
	
}