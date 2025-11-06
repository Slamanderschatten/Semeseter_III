
using UnityEngine;

namespace flora
{
    public class FlowerGrowing : MonoBehaviour
    {
        public float minGrowingDuration;
        public float maxGrowingDuration;
        private float duration;
        private float progress;

        void Awake()
        {
            duration = Random.Range(minGrowingDuration, maxGrowingDuration);
            transform.localScale = Vector3.zero;
        }


        void Update()
        {
            progress += Time.deltaTime / duration;
            transform.localScale = Vector3.Lerp(Vector3.zero, Vector3.one, progress);
        }

    }
}