import re
import json

try:
    # PowerShell Out-File defaults to UTF-16LE for some versions, or might have BOM
    try:
        with open('playlist_source.html', 'r', encoding='utf-16') as f:
            content = f.read()
    except:
         with open('playlist_source.html', 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()

    # Regex to find videoId and title in the JSON-like structure of YouTube HTML
    # We look for the pattern "videoId":"..." followed closely by "title":{"runs":[{"text":"..."}]}
    # This might need adjustment if the HTML structure varies
    
    # Let's try to find potential videoRenderers first
    video_renderers = re.findall(r'\"videoRenderer\":\{(.*?)\"navigationEndpoint\"', content)
    
    extracted_videos = []
    seen_ids = set()

    for renderer in video_renderers:
        video_id = re.search(r'\"videoId\":\"(.*?)\"', renderer)
        title = re.search(r'\"title\":\{\"runs\":\[\{\"text\":\"(.*?)\"\}\]', renderer)
        
        if video_id and title:
            vid = video_id.group(1)
            ttl = title.group(1)
            
            if vid not in seen_ids:
                extracted_videos.append({
                    "id": vid,
                    "title": ttl,
                    "videoId": vid,
                    "thumbnailUrl": f"https://img.youtube.com/vi/{vid}/mqdefault.jpg"
                })
                seen_ids.add(vid)

    print(json.dumps(extracted_videos[:20], indent=2))

except Exception as e:
    print(f"Error: {e}")
