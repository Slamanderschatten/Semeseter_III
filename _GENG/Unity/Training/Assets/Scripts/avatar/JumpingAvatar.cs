using System;
using Unity.VisualScripting;
using UnityEngine;

namespace avatar
{
    public class JumpingAvatar : MonoBehaviour
    {
        public float speed;
        
        
        private Animator animator;

        private void Awake()
        {
            animator = GetComponentInChildren<Animator>();
        }

        public void JumpTo(Vector3 targetPosition)
        {
            
            // Bewegung mit gleichzeitiger sanfter Rotation
            iTween.MoveTo(gameObject, iTween.Hash(
                "position", targetPosition,
                "speed", speed,
                "easetype", iTween.EaseType.easeInOutSine,
                "orienttopath", true,
                "looktime", 0.5f,
                "axis", "y",
                "onstart", "AniStartet",
                "oncomplete", "AniComplete"
            ));
        }
        
        
        private void AniStartet()
        {
            Debug.Log("AniStartet");
            animator.SetTrigger("Walk");
        }
        
        
        private void AniComplete()
        {
            Debug.Log("AniComplete");
            animator.SetTrigger("Stop");
        }
    }
}