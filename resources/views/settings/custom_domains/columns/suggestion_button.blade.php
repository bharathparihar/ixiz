<div>
    <a type="button" class="btn btn-primary ms-auto" target="_blank" href="{{ asset('custom_domain_guide/custom_domain_guide.pdf') }}">
        <i class="fas fa-download"></i>   {{ __('messages.custom_domain.cpanel_guide_download') }}
    </a>
    <a style="font-size: 15px; margin-left: 10px;" class="text-primary" href="{{ route('setting.index', ['section' => 'custom_domain_guide']) }}">
        {{ __('messages.custom_domain.steps_before_approving_custom_domain') }}
    </a>
</div>
