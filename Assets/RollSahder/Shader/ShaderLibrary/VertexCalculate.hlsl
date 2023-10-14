#ifndef VERTEXCALCULATE_INCLUDED
#define VERTEXCALCULATE_INCLUDED

#include "arcLengthToAngle.hlsl"

void VertexCalc_half(float3 Vert, float StartAngle, float AnglePerUnit, float UnrolledAngle, float Pitch, out float3 VertOut) {

          float fromStart =   Vert.z * AnglePerUnit;

                float fromOrigin = StartAngle - fromStart;
                float lengthToHere = arcLengthToAngle_half(fromOrigin,Pitch);
                float lengthToStart = arcLengthToAngle_half(StartAngle,Pitch);
        
                if (fromStart < UnrolledAngle) {
                            float lengthToSplit = arcLengthToAngle_half(StartAngle - UnrolledAngle,Pitch);
                            Vert.z = lengthToSplit - lengthToHere;
                            Vert.y = Vert.y;
                        }
                        else {
                            float radiusAtSplit = Pitch * (StartAngle - UnrolledAngle);
                            float radius = Pitch * fromOrigin;

                            float shifted = fromStart - UnrolledAngle;

                            Vert.y = Vert.y + (radiusAtSplit - cos(shifted) * radius);
                            Vert.z = sin(shifted) * radius;
                        }
	VertOut = Vert;
}
#endif