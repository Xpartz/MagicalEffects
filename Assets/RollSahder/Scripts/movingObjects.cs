using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.VFX;

[ExecuteInEditMode]
public class movingObjects : MonoBehaviour
{
    public Transform _targetTransform;
    public VisualEffect _visualEffects;


    void Start()
    {
        _visualEffects = GetComponent<VisualEffect>(); 
    }

    private void Update()
    {
        _visualEffects.SetVector3("targetPos", _targetTransform.localPosition);
    }

}
