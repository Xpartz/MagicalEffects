using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class flameController : MonoBehaviour
{
    public Renderer objectRenderer;
    public Material targetMaterial;
    public float startDissolveValue = -3f;
    public float endDissolveValue = 5f;
    public float dissolveDuration = 2.0f;
    public AnimationCurve dissolveCurve;

    public float startRollValue = 0f;
    public float endRollValue = 360f;
    public float rollDuration = 2.0f;
    public AnimationCurve rollCurve;

    public float delayBetweenAnimations = 1.0f; // Промежуток между анимациями

    private bool isAnimating = false;

    private float defaultStartDissolveValue;
    private float defaultStartRollValue;
    public Material[] targetMaterials;

    void Start()
    {
        objectRenderer = GetComponent<Renderer>();
        targetMaterials = objectRenderer.materials;

        defaultStartDissolveValue = startDissolveValue;
        defaultStartRollValue = startRollValue;
    }

    void Update()
    {
        if (Input.GetMouseButtonDown(1) && !isAnimating)
        {
            StartCoroutine(PlayRollThenDissolve());
        }

        
    }

    IEnumerator PlayRollThenDissolve()
    {
        isAnimating = true;

        RollAnimation(startRollValue, endRollValue, rollDuration, rollCurve);
        yield return new WaitForSeconds(rollDuration + delayBetweenAnimations);
        DissolveAnimation(startDissolveValue, endDissolveValue, dissolveDuration, dissolveCurve);

        yield return new WaitForSeconds(dissolveDuration + delayBetweenAnimations);
        isAnimating = false;
    }

    void DissolveAnimation(float start, float end, float duration, AnimationCurve curve)
    {

        targetMaterials[0].DOFloat(end, "_Dissolve", duration)
            .From(start)
            .SetEase(curve);

        targetMaterials[1].DOFloat(end, "_Dissolve", duration)
            .From(start)
            .SetEase(curve);
    }

    void RollAnimation(float start, float end, float duration, AnimationCurve curve)
    {
        targetMaterials[0].DOFloat(end, "_UnrolledAngle", duration)
            .From(start)
            .SetEase(curve);

        targetMaterials[1].DOFloat(end, "_UnrolledAngle", duration)
            .From(start)
            .SetEase(curve);
    }
}
